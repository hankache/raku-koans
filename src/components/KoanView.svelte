<script lang="ts">
  import { untrack } from 'svelte';
  import { koanById, neighbours, revealAnswer, runKoan, sectionOf, getRuntime } from '../lib/koans';
  import { progress } from '../lib/progress.svelte';
  import type { Report } from '../lib/tap';
  import { inlineCode } from '../lib/inline-code';
  import Editor from './Editor.svelte';
  import Meditation from './Meditation.svelte';

  let { id }: { id: string } = $props();

  const koan = $derived(koanById.get(id)!);
  const section = $derived(sectionOf(id));
  const nav = $derived(neighbours(id));
  const index = $derived(section.koans.indexOf(koan) + 1);

  // App keys this component by koan id and waits for saved progress to load,
  // so reading it once here is enough (and must not re-run after each save).
  let code = $state(untrack(() => progress.get(id)?.code ?? koanById.get(id)!.code));
  let report = $state<Report | null>(null);
  let editor: Editor;
  // How far into the koan the last run got (assertions passed before the first failure),
  // and how many more this run got past: drives the encouragement line.
  let reached = 0;
  let gained = $state(0);
  let running = $state(false);
  // Counts runs, so the editor redraws the failing line's mark after each one.
  let runs = $state(0);
  // The line of the answer spot the cursor is on, if any. Only the learner puts it there:
  // a run clears it, and the cursor then goes to the start of the failing line.
  let cursorSpot = $state<number | null>(null);
  // Only surfaced if the interpreter fails to load.
  const LOAD_ERROR = 'Could not load the Raku interpreter. Check your connection and reload the page.';
  let runtimeError = $state<string | undefined>();
  getRuntime().ready.catch(e => {
    console.error(e);
    runtimeError = LOAD_ERROR;
  });

  async function run() {
    if (running) return;
    running = true;
    cursorSpot = null;
    const ranFor = id;
    let r;
    try {
      r = await runKoan(code);
    } catch {
      // The interpreter failed to load; the idle panel says so.
      runtimeError = LOAD_ERROR;
      return;
    } finally {
      running = false;
    }
    if (ranFor !== id) return; // navigated away meanwhile
    report = r;
    runs++;
    if (r.status !== 'error') {
      const now = r.status === 'passed' ? r.tests.length : r.tests.findIndex(t => !t.ok);
      gained = Math.max(0, now - reached);
      reached = now;
    }
    progress.record(id, code, r.status === 'passed');
    // Back to the code: the start of the failing line (red stripe), or where you were.
    // A pass leaves you alone, for the "Next koan" button.
    if (r.status === 'failed') editor.focusLine(r.failure.line);
    else if (r.status === 'error') editor.focusLine(r.line);
  }

  function reset() {
    code = koan.code;
    report = null;
    reached = gained = 0;
    progress.resetCode(id, koan.code);
  }

  const markLine = $derived(
    report?.status === 'failed' ? report.failure.line : report?.status === 'error' ? report.line : undefined,
  );

  // Where each answer goes, for the editor: the text around each ___ of the koan.
  const spots = $derived.by(() => {
    const lines = koan.code.trimEnd().split('\n');
    return koan.answers.map(a => {
      const [before, after] = lines[a.line].split('___');
      return { line: a.line, before, after };
    });
  });

  // The hidden answer the result panel offers, for the spot the cursor is on (none if it's right).
  const hint = $derived.by(() => {
    if (!cursorSpot || report?.status === 'passed') return null;
    const found = revealAnswer(koan, code, cursorSpot);
    return found?.line === cursorSpot ? found : null;
  });
</script>

<svelte:head><title>{koan.title} · Raku Koans</title></svelte:head>

<article>
  <nav class="crumbs">
    <a href="#/">Path</a> <span>/</span> {section.title} <span>/</span> {koan.title} · {index} of {section.koans.length}
  </nav>

  <div class="layout">
    <div class="main">
      <h1>
        {koan.title}
        {#if progress.get(id)?.status === 'passed'}<span class="badge">passed</span>{/if}
      </h1>
      {#if koan.intro}
        <p class="intro">
          {#each inlineCode(koan.intro) as part}{#if part.code}<code class:blank={part.text === '___'}>{part.text}</code>{:else}{part.text}{/if}{/each}
        </p>
      {/if}

      <Editor
        value={code}
        onchange={c => (code = c)}
        onrun={run}
        bind:this={editor}
        {markLine}
        markKind={report?.status === 'error' ? 'error' : 'fail'}
        markRun={runs}
        {spots}
        onspot={line => (cursorSpot = line)}
      />

      <div class="actions">
        <button class="primary" onclick={run} disabled={running}>{running ? 'Running…' : 'Run'}</button>
        <button onclick={reset} title="Restore the original koan">Reset</button>
        <span class="spacer"></span>
        {#if nav.prev}<a href="#/koan/{nav.prev.id}" class="nav">← {nav.prev.title}</a>{/if}
        {#if nav.next}<a href="#/koan/{nav.next.id}" class="nav">{nav.next.title} →</a>{/if}
      </div>
    </div>

    <aside>
      <Meditation {report} {gained} {running} {hint} onuse={() => hint && editor.fillAnswer(hint)} {runtimeError} nextHref={nav.next ? `#/koan/${nav.next.id}` : undefined} />
    </aside>
  </div>
</article>

<style>
  article { padding: 1.5rem 0 3rem; }
  .crumbs { font-size: 0.85rem; color: var(--ink-faint); margin-bottom: 1rem; }
  .crumbs a { color: var(--ink-soft); }
  .crumbs span { margin: 0 0.3rem; }
  .layout { display: grid; grid-template-columns: minmax(0, 1fr) 340px; gap: 1.5rem; align-items: start; }
  aside { position: sticky; top: 1rem; }
  h1 { font-size: clamp(1.6rem, 4vw, 2.2rem); display: flex; align-items: center; gap: 0.7rem; flex-wrap: wrap; }
  .badge {
    font-family: var(--font-body);
    font-size: 0.75rem;
    font-weight: 600;
    background: var(--pass);
    color: var(--bg);
    padding: 0.15rem 0.6rem;
  }
  .intro code {
    font-family: var(--font-mono);
    font-size: 0.88em;
    padding: 0.05em 0.35em;
    color: var(--ink);
    background: color-mix(in srgb, var(--ink) 7%, transparent);
    white-space: nowrap;
  }
  .intro code.blank { color: var(--syn-blank); background: color-mix(in srgb, var(--syn-blank) 14%, transparent); }
  .intro { color: var(--ink-soft); margin: 0.6rem 0 1.2rem; max-width: 42rem; }
  .actions { display: flex; gap: 0.6rem; align-items: center; margin-top: 1rem; flex-wrap: wrap; }
  .spacer { flex: 1; }
  .nav { font-size: 0.88rem; color: var(--ink-soft); text-decoration: none; }
  .nav:hover { color: var(--ink); }

  @media (max-width: 860px) {
    .layout { grid-template-columns: minmax(0, 1fr); }
    aside { position: static; }
  }
</style>
