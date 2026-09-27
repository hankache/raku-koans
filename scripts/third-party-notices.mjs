// Writes THIRD-PARTY-NOTICES.md: the licenses of everything the built site ships.
// Run after changing dependencies: npm run notices
import { execSync } from 'node:child_process';
import { readdirSync, readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';

// Runtime dependencies (and theirs), plus Svelte, whose runtime is compiled into the bundle.
const dirs = execSync('npm ls --omit=dev --all --parseable', { encoding: 'utf8' })
  .trim().split('\n').slice(1);
dirs.push(join(process.cwd(), 'node_modules/svelte'));

const groups = new Map(); // license text -> packages
for (const dir of [...new Set(dirs)].sort()) {
  const pkg = JSON.parse(readFileSync(join(dir, 'package.json'), 'utf8'));
  const file = readdirSync(dir).find(f => /^licen[cs]e/i.test(f));
  const text = file ? readFileSync(join(dir, file), 'utf8').trim() : `(${pkg.license}; no license file in the package)`;
  if (!groups.has(text)) groups.set(text, []);
  groups.get(text).push(`${pkg.name} ${pkg.version} (${pkg.license})`);
}

let out = `# Third-party notices

Raku Koans ships the following third-party software in the built site. Their licenses are
reproduced below.

## Raku.js (Raku++)

The interpreter the koans run on: \`public/runtime/rakujs.js\` and \`rakujs.wasm\`, downloaded by
\`npm run fetch-runtime\` from the Raku++ releases at https://github.com/ash/rakupp/releases.
Licensed under the Artistic License 2.0, the same license as Raku Koans' code; see \`LICENSE\`.

## Ace (Raku syntax highlighting)

The editor's Raku highlighting (\`src/lib/raku-mode.ts\`, \`src/lib/raku-words.ts\`) is adapted
from Ace's Raku mode (ace-builds 1.44.0, \`src/mode/raku_highlight_rules.js\`),
https://github.com/ajaxorg/ace, under the BSD 3-Clause License:

\`\`\`
${readFileSync(new URL('./licenses/Ace-BSD-3-Clause.txt', import.meta.url), 'utf8').trim()}
\`\`\`

## Fonts

Fraunces, Inter and JetBrains Mono are loaded from Google Fonts at run time and are not
distributed with the site. All three are under the SIL Open Font License 1.1.

## JavaScript packages
`;
for (const [text, pkgs] of groups) {
  out += `\n### ${pkgs.map(p => p.split(' (')[0]).join(', ')}\n\n${pkgs.map(p => `- ${p}`).join('\n')}\n\n\`\`\`\n${text}\n\`\`\`\n`;
}
// Apache-2.0 asks that recipients get the full license, not just the per-package notice.
if ([...groups.values()].flat().some(p => p.includes('(Apache-2.0)'))) {
  const apache = readFileSync(new URL('./licenses/Apache-2.0.txt', import.meta.url), 'utf8').trim();
  out += `\n## Apache License 2.0\n\nThe full text, for the Apache-2.0 packages above.\n\n\`\`\`\n${apache}\n\`\`\`\n`;
}
writeFileSync('THIRD-PARTY-NOTICES.md', out);
console.log(`✓ THIRD-PARTY-NOTICES.md: ${dirs.length} packages, ${groups.size} distinct license texts`);
