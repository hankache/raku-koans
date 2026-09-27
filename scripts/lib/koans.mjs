// Reads koans/ into a structured list. Shared by build-koans and check-koans.
//
// Layout:
//   koans/_prelude.raku                   one line, prepended to every run
//   koans/NN-section/_section.json        { "title", "blurb" }
//   koans/NN-section/NN-name.raku          the koan: header comments, then code with ___ blanks
//   koans/NN-section/NN-name.solution.raku the same code, blanks filled (never shipped to the browser)
//
// Numeric prefixes set the order but are dropped from ids, so koans can be
// reordered without losing anyone's saved progress.
import { existsSync, readdirSync, readFileSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

export const koansDir = fileURLToPath(new URL('../../koans/', import.meta.url));
// Closes the block the prelude opens (see koans/_prelude.raku).
export const EPILOGUE = '\n}\ndone-testing;\n';

const slug = name => name.replace(/^\d+-/, '').replace(/(\.solution)?\.raku$/, '');
const HEADER = /^#\s*(\w+):\s*(.*)$/;

/** The prelude folded onto one line, so error line numbers shift by exactly one. */
export function readPrelude() {
  return readFileSync(join(koansDir, '_prelude.raku'), 'utf8')
    .split('\n')
    .map(l => l.trim())
    .filter(l => l && !l.startsWith('#'))
    .join(' ') + '\n';
}

export function readKoans() {
  const sections = [];
  for (const dir of readdirSync(koansDir).filter(d => /^\d+-/.test(d)).sort()) {
    const path = join(koansDir, dir);
    const meta = JSON.parse(readFileSync(join(path, '_section.json'), 'utf8'));
    const section = { id: slug(dir), title: meta.title, blurb: meta.blurb ?? '', koans: [] };

    const files = readdirSync(path).filter(f => /^\d+-.*\.raku$/.test(f) && !f.endsWith('.solution.raku')).sort();
    for (const file of files) {
      const lines = readFileSync(join(path, file), 'utf8').split('\n');
      const meta = {};
      while (lines.length && HEADER.test(lines[0])) {
        const [, key, value] = lines.shift().match(HEADER);
        meta[key] = value;
      }
      const solutionPath = join(path, file.replace(/\.raku$/, '.solution.raku'));
      section.koans.push({
        id: `${section.id}/${slug(file)}`,
        title: meta.title ?? slug(file),
        intro: meta.intro ?? '',
        code: lines.join('\n').trim() + '\n',
        file: join(dir, file),
        solution: existsSync(solutionPath) ? readFileSync(solutionPath, 'utf8') : null,
      });
    }
    sections.push(section);
  }
  return sections;
}
