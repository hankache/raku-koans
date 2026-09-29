// Turns a koan run (TAP from Raku's Test module + stderr) into something to show.
import type { RunResult } from './runtime/wasm-runtime';

export interface TestResult {
  n: number;
  ok: boolean;
  description: string;
  /** 1-based line in the learner's code, when Raku reported one. */
  line?: number;
  /** '# …' diagnostics that followed the test, minus the leading '# '. */
  diag: string[];
  /**
   * The values from Test's "expected:"/"got:" lines. In a koan the learner writes the
   * *expected* side, so it is their answer; *got* is what Raku actually computed.
   */
  answer?: string;
  actual?: string;
  /** The failing line still has a ___ in it. */
  blank?: boolean;
}

export type Report =
  | { status: 'passed'; tests: TestResult[]; output: string[] }
  | { status: 'failed'; tests: TestResult[]; failure: TestResult; output: string[] }
  | { status: 'error'; tests: TestResult[]; message: string; line?: number; output: string[] };

const ANSI = /\x1b\[[0-9;]*m/g;
const TEST = /^(not )?ok (\d+)(?: - (.*))?$/;
const AT_LINE = /(?:at web line|at line) (\d+)/;

/**
 * @param result  what the runtime returned
 * @param code    the learner's code (without prelude), to spot unfilled blanks
 * @param offset  how many prelude lines were prepended before `code`
 */
export function parseRun(result: RunResult, code: string, offset: number): Report {
  const codeLines = code.trimEnd().split('\n');
  // Errors at end-of-input can point into the appended epilogue; clamp them.
  const toUserLine = (n: number) =>
    n - offset >= 1 ? Math.min(n - offset, codeLines.length) : undefined;

  const tests: TestResult[] = [];
  const output: string[] = [];
  const errors: string[] = [];
  let last: TestResult | undefined;
  // A quoted value containing newlines spills onto following stderr lines without '#'.
  let openQuote = false;
  const opensQuote = (d: string) => {
    const v = d.replace(/^\s*\w+:\s*/, '');
    return v.startsWith("'") && (v.length === 1 || !v.endsWith("'"));
  };

  // A failure inside a subtest: its line and description, to credit the subtest's own result.
  let inner: { line?: number; description?: string } = {};
  let lineFromInner = false;

  for (const { stream, text: raw } of result.lines) {
    const text = raw.replace(ANSI, '');

    // Indented lines belong to a subtest: remember its first failure, show nothing.
    if (/^\s+\S/.test(text)) {
      const s = text.trim();
      const it = s.match(TEST);
      if (it?.[1] && inner.description === undefined) inner.description = it[3] ?? '';
      const at = s.startsWith('#') && inner.description !== undefined ? s.match(AT_LINE) : null;
      if (at && inner.line === undefined) inner.line = toUserLine(Number(at[1]));
      continue;
    }

    // Our prelude's "at web line" diag inside a subtest comes out unindented.
    if (inner.description !== undefined && inner.line === undefined && text.startsWith('#')) {
      const at = text.match(AT_LINE);
      const line = at ? toUserLine(Number(at[1])) : undefined;
      if (line !== undefined) {
        inner.line = line;
        continue;
      }
    }

    const t = stream === 'out' ? text.match(TEST) : null;
    if (openQuote && last && stream === 'err' && !text.startsWith('#')) {
      last.diag[last.diag.length - 1] += '\n' + text;
      openQuote = !text.endsWith("'");
      continue;
    }
    openQuote = false;
    if (t) {
      const raw = t[3] ?? '';
      // TAP directives: a TODO failure doesn't count, and a skip is a pass.
      const todo = /\s*# TODO\b.*$/i;
      const skip = raw.match(/^\s*# skip\s*(.*)$/i);
      last = {
        n: Number(t[2]),
        ok: !t[1] || todo.test(raw),
        description: skip ? `skipped: ${skip[1]}` : raw.replace(todo, ''),
        diag: [],
      };
      lineFromInner = false;
      if (!last.ok && inner.description !== undefined) {
        if (inner.description) last.description += ` › ${inner.description}`;
        last.line = inner.line;
        lineFromInner = inner.line !== undefined;
      }
      inner = {};
      tests.push(last);
    } else if (text.startsWith('#')) {
      if (/^# (Looks like you|Subtest:)/.test(text)) continue;
      const diag = text.replace(/^# ?/, '');
      const at = diag.match(AT_LINE);
      if (last && !last.ok && at) {
        const line = toUserLine(Number(at[1]));
        if (line !== undefined && !lineFromInner) last.line = line;
      } else if (last) {
        last.diag.push(diag);
        openQuote = opensQuote(diag);
      }
    } else if (/^1\.\.\d+$/.test(text)) {
      // plan line
    } else if (stream === 'err') {
      errors.push(text);
    } else {
      output.push(text); // the learner's own say/print
    }
  }

  if (result.aborted === 'timeout') {
    return { status: 'error', tests, output,
      message: 'Your code ran for too long and was stopped. Is there an infinite loop?' };
  }
  if (result.aborted === 'crash') {
    return { status: 'error', tests, output,
      message: /RangeError|call stack/i.test(result.message ?? '')
        ? 'Recursion went too deep for the browser (about 200 levels is the limit).'
        : `The interpreter crashed: ${result.message}` };
  }

  // The first failing test is the koan's lesson; report it even if something
  // died afterwards (multi-line diagnostics also land on stderr).
  const failure = tests.find(t => !t.ok);
  if (failure) {
    for (const d of failure.diag) {
      const m = d.match(/^\s*(expected|got):\s?([\s\S]*)$/);
      if (m?.[1] === 'expected') failure.answer = m[2].trim();
      if (m?.[1] === 'got') failure.actual = m[2].trim();
    }
    failure.blank = failure.line !== undefined && codeLines[failure.line - 1]?.includes('___');
    return { status: 'failed', tests, failure, output };
  }
  // A compile error or an exception outside of any test.
  if (errors.length && (result.rc !== 0 || !tests.length)) {
    const joined = errors.join('\n');
    const at = joined.match(AT_LINE);
    const message = errors[0].replace(/^===SORRY!=== /, '').replace(/ at line \d+/, '');
    return { status: 'error', tests, output, message, line: at ? toUserLine(Number(at[1])) : undefined };
  }

  if (result.rc !== 0 || !tests.length) {
    return { status: 'error', tests, output, message: 'The koan did not finish cleanly.' };
  }
  return { status: 'passed', tests, output };
}
