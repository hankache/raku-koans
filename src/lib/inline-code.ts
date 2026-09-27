/**
 * Splits text on Markdown-style code spans: `code`, or ``code with a ` in it``.
 * Returns plain parts and code parts, for rendering without any HTML injection.
 */
export interface Part {
  code: boolean;
  text: string;
}

export function inlineCode(text: string): Part[] {
  const parts: Part[] = [];
  const span = /(`+)([\s\S]+?)\1(?!`)/g;
  let last = 0;
  for (const m of text.matchAll(span)) {
    if (m.index! > last) parts.push({ code: false, text: text.slice(last, m.index) });
    parts.push({ code: true, text: m[2] });
    last = m.index! + m[0].length;
  }
  if (last < text.length) parts.push({ code: false, text: text.slice(last) });
  return parts;
}
