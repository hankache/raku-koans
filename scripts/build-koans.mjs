// koans/ → src/generated/koans.json (the manifest the app loads).
// Whole solutions stay out of the bundle; each blank's answer goes in, for the result panel's hidden answer.
import { mkdirSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { EPILOGUE, blanksOf, readKoans, readPrelude } from './lib/koans.mjs';

const sections = readKoans().map(s => ({
  ...s,
  koans: s.koans.map(k => ({ id: k.id, title: k.title, intro: k.intro, code: k.code, answers: blanksOf(k).blanks.map(b => ({ line: b.line, answer: b.answer })) })),
}));
const manifest = { prelude: readPrelude(), epilogue: EPILOGUE, sections };

const out = fileURLToPath(new URL('../src/generated/', import.meta.url));
mkdirSync(out, { recursive: true });
writeFileSync(out + 'koans.json', JSON.stringify(manifest, null, 2) + '\n');
const count = sections.reduce((n, s) => n + s.koans.length, 0);
console.log(`✓ ${count} koans in ${sections.length} sections → src/generated/koans.json`);
