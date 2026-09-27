// Runs every koan through Raku.js (the same engine as the browser) and checks:
//   • the koan has a solution file
//   • the unsolved koan contains a ___, and every line with a ___ fails on its own
//     (a blank that passes unfilled, or a crash that hides later blanks, is caught)
//   • the solution has no ___ and passes every test
//   • types are compared with is-deeply: `is` compares strings, and every type object
//     stringifies to '', so `is $x.WHAT, Int` would accept any type at all
import { EPILOGUE, readKoans, readPrelude } from './lib/koans.mjs';
import { loadRaku } from './lib/raku-node.mjs';

const raku = await loadRaku();
const prelude = readPrelude();
const run = code => raku.run(prelude + code + EPILOGUE);
// As in TAP: a `not ok … # TODO` is not a failure.
const passed = ({ rc, lines }) =>
  rc === 0 && !lines.some(l => l.text.startsWith('not ok') && !/# TODO\b/i.test(l.text));
// Learner lines reported as failing: the prelude adds "at web line N" to each failure.
const failingLines = ({ lines }) =>
  new Set(lines.flatMap(l => [...l.text.matchAll(/at web line (\d+)/g)].map(m => Number(m[1]) - 1)));

let failures = 0;
const fail = (koan, why, lines = []) => {
  failures++;
  console.log(`✗ ${koan.file}: ${why}`);
  for (const l of lines) console.log(`    ${l.text.replace(/\x1b\[[0-9;]*m/g, '')}`);
};

console.log(`Raku++ ${raku.version}`);
for (const section of readKoans()) {
  for (const koan of section.koans) {
    if (!koan.code.includes('___')) { fail(koan, 'koan has no ___ blank to fill in'); continue; }
    const weak = koan.code.split('\n').findIndex(l => /^\s*is\s.*\.WHAT\b/.test(l));
    if (weak >= 0) fail(koan, `line ${weak + 1} compares a type with is; use is-deeply`);
    const unsolved = run(koan.code);
    const failing = failingLines(unsolved);
    const silent = koan.code.split('\n').flatMap((l, i) => (l.includes('___') && !failing.has(i + 1) ? [i + 1] : []));
    if (silent.length) fail(koan, `blank on line ${silent.join(', ')} does not fail when left unfilled`, unsolved.lines);

    if (koan.solution == null) { fail(koan, 'missing .solution.raku'); continue; }
    if (koan.solution.includes('___')) { fail(koan, 'solution still contains ___'); continue; }
    const solved = run(koan.solution);
    if (!passed(solved)) { fail(koan, 'solution does not pass', solved.lines); continue; }

    console.log(`✓ ${koan.id}`);
  }
}

if (failures) {
  console.log(`\n${failures} problem(s).`);
  process.exit(1);
}
console.log('\nAll koans are sound.');
