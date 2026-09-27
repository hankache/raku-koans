// koans/ → src/generated/koans.json (the manifest the app loads).
// Solutions are deliberately left out of the bundle.
import { mkdirSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { EPILOGUE, readKoans, readPrelude } from './lib/koans.mjs';

const sections = readKoans().map(s => ({
  ...s,
  koans: s.koans.map(({ id, title, intro, code }) => ({ id, title, intro, code })),
}));
const manifest = { prelude: readPrelude(), epilogue: EPILOGUE, sections };

const out = fileURLToPath(new URL('../src/generated/', import.meta.url));
mkdirSync(out, { recursive: true });
writeFileSync(out + 'koans.json', JSON.stringify(manifest, null, 2) + '\n');
const count = sections.reduce((n, s) => n + s.koans.length, 0);
console.log(`✓ ${count} koans in ${sections.length} sections → src/generated/koans.json`);
