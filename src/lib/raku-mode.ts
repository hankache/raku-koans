// Raku syntax highlighting for CodeMirror 6: a port of Ace's Raku mode
// (ace-builds 1.44.0, src/mode/raku_highlight_rules.js; BSD-3-Clause, see THIRD-PARTY-NOTICES.md).
// The states and rules follow Ace's, in the same order. Deliberate fixes are marked "Fix:".
import { StreamLanguage, type StreamParser, type StringStream } from '@codemirror/language';
import { tags as t } from '@lezer/highlight';
import { builtins, constants, keywords, types, wordOperators } from './raku-words';

type Mode = 'start' | 'qqstring' | 'qqinterpolation' | 'blockComment' | 'qheredoc' | 'qqheredoc' | 'qqheredocInterpolation';
interface State {
  mode: Mode;
}

// Every rule is anchored: StringStream.match tries it at the current position.
// Addition: binary and octal literals, and underscores in hex.
const hex = /^0(?:x[0-9a-fA-F_]+|b[01_]+|o[0-7_]+)\b/;
// Addition: digits from any script (\p{Nd}), which Raku accepts, and vulgar fractions like ⅒.
const number = /^(?:[+-.]?\p{Nd}[\p{Nd}_]*(?:(?:\.\p{Nd}[\p{Nd}_]*)?(?:[eE][+-]?\d[\d_]*)?)?i?(?![\p{L}\p{N}_])|\p{No})/u;
const boolean = /^(?:True|False)\b/;
const version = /^v[0-9](?:\.[a-zA-Z0-9*])*\b/;
// Addition: names may use letters from any script ($Δ), and an apostrophe or dash between
// letters ($isn't, is-deeply), as Raku allows. :: joins package names (X::AdHoc).
const name = String.raw`[\p{L}_][\p{L}\p{N}_]*(?:['-][\p{L}_][\p{L}\p{N}_]*)*`;
const identifier = new RegExp(`^${name}(?:::${name})*`, 'u');
const variable = new RegExp(`^[$@%&][?*!.^]?(?:${name}|\\d+)`, 'u');
const specialVariable = /^(?:\$[/|!]?|@\$\/)/;
// Addition: any Unicode math symbol (\p{Sm}: ∈ ∪ ∩ ⊆ ± √ × ≤ …), as Raku has many.
const operator = /^(?:=|<|>|\+|\*|-|\/|~|%|\?|!|\^|\.|:|,|»|«|\||&|⚛|∘|\p{Sm})/u;
const unicodeConstant = /^(?:𝑒|π|τ|∞)/;
const singleQuoted = /^'(?:\\.|[^'\\])*?'/;
const wordQuoting = /^<[a-zA-Z0-9 ]*>/;
// Fix: Ace writes the optional prefix as [m|rx], a character class; it means m or rx.
// Addition: adverbs such as m:g/…/.
const regexp = /^(?:(?:m|rx)(?::\w+)*)?\/(?:\[(?:\\\]|[^\]])+\]|\\\/|[^\]/])*\/\w*\s*(?=[).,;]|$)/;
// Fix: Ace's embedded comments are greedy (.*), running to the last ) on the line.
const embeddedComment = /^#[`=](?:\(.*?\)|\[.*?\])/;
// Addition: s/…/…/ and tr/…/…/ (with adverbs, like s:g), which Ace leaves as a name and operators.
const substitution = /^(?:s|S|tr|TR)(?::\w+)*\/(?:\\.|[^\/\\])*\/(?:\\.|[^\/\\])*\//;
// Addition: q{…}, qq[…], Q[…] and friends, which Ace reads as a name followed by code.
const quoteConstruct = /^(?:Q|qq?)(?::\w+)*\s*(?:\{[^}]*\}|\[[^\]]*\]|\([^)]*\)|<[^>]*>|\/[^\/]*\/)/;
// Fix: also \c[…] and \x of any length, not just two hex digits.
const escape = /^\\(?:[nrtef\\"$0{]|[0-7]{1,3}|x[0-9A-Fa-f]+|x\[[0-9A-Fa-f, ]+\]|c\[[^\]]*\])/;

/** Ace's keywordMapper: a word is a type, built-in, keyword, constant or word operator. */
function word(w: string): string {
  if (types.has(w)) return 'type';
  if (builtins.has(w)) return 'builtin';
  if (keywords.has(w)) return 'keyword';
  if (constants.has(w)) return 'constant';
  if (wordOperators.has(w)) return 'operator';
  return 'identifier';
}

/** The rules shared by code and by {…} inside strings. */
function code(stream: StringStream): string | null {
  if (stream.match(hex) || stream.match(number)) return 'number';
  if (stream.match(boolean)) return 'constant';
  if (stream.match(version)) return 'constant';
  const w = stream.match(identifier) as RegExpMatchArray | null;
  if (w) return word(w[0]);
  if (stream.match(variable) || stream.match(specialVariable)) return 'variable';
  if (stream.match(operator)) return 'operator';
  if (stream.match(unicodeConstant)) return 'constant';
  return null;
}

/** A string that interpolates: $variables and {…} blocks, until the closing token. */
function interpolating(stream: StringStream, state: State, close: RegExp, block: Mode, after: Mode): string {
  if (stream.match(escape)) return 'escape';
  if (stream.match(variable) || stream.match(specialVariable)) return 'variable';
  if (stream.eat('{')) {
    state.mode = block;
    return 'bracket';
  }
  if (stream.match(close)) {
    state.mode = after;
    return 'string';
  }
  stream.next();
  return 'string';
}

/** {…} inside a string: code again, until }. */
function interpolation(stream: StringStream, state: State, back: Mode): string | null {
  if (stream.eat('}')) {
    state.mode = back;
    return 'bracket';
  }
  if (stream.eatSpace()) return null;
  const token = code(stream);
  if (token) return token;
  if (stream.match(singleQuoted)) return 'string';
  if (stream.match(regexp)) return 'regexp';
  stream.next();
  return null;
}

export const rakuParser: StreamParser<State> = {
  name: 'raku',
  startState: () => ({ mode: 'start' }),
  copyState: s => ({ ...s }),

  token(stream, state) {
    switch (state.mode) {
      case 'qqstring':
        return interpolating(stream, state, /^"/, 'qqinterpolation', 'start');
      case 'qqinterpolation':
        return interpolation(stream, state, 'qqstring');
      case 'qqheredoc':
        return interpolating(stream, state, /^\s*END$/, 'qqheredocInterpolation', 'start');
      case 'qqheredocInterpolation':
        return interpolation(stream, state, 'qqheredoc');
      case 'qheredoc':
        if (stream.match(/^\s*END$/)) state.mode = 'start';
        else stream.skipToEnd();
        return 'string';
      case 'blockComment':
        if (stream.sol() && stream.match(/^=end +[a-zA-Z_0-9]*/)) state.mode = 'start';
        else stream.skipToEnd();
        return 'docComment';
    }

    // 'start': ordinary code.
    if (stream.eatSpace()) return null;
    if (stream.match(embeddedComment)) return 'comment';
    if (stream.sol() && stream.match(/^=begin\b/)) {
      state.mode = 'blockComment';
      stream.skipToEnd();
      return 'docComment';
    }
    if (stream.match(/^q[xw]?:to\/END\/;/)) {
      state.mode = 'qheredoc';
      return 'string';
    }
    if (stream.match(/^qq[xw]?:to\/END\/;/)) {
      state.mode = 'qqheredoc';
      return 'string';
    }
    if (stream.match(regexp) || stream.match(substitution)) return 'regexp';
    if (stream.match(quoteConstruct)) return 'string';
    if (stream.match(singleQuoted)) return 'string';
    if (stream.eat('"')) {
      state.mode = 'qqstring';
      return 'string';
    }
    if (stream.match(wordQuoting)) return 'string';
    const token = code(stream);
    if (token) return token;
    if (stream.match(/^#.*$/)) return 'comment';
    if (stream.match(/^[[({\])}]/)) return 'bracket';
    stream.next();
    return null;
  },

  tokenTable: {
    keyword: t.keyword,
    type: t.typeName,
    builtin: t.standard(t.variableName),
    identifier: t.name,
    constant: t.atom,
    number: t.number,
    variable: t.variableName,
    operator: t.operator,
    string: t.string,
    escape: t.escape,
    regexp: t.regexp,
    comment: t.comment,
    docComment: t.docComment,
    bracket: t.bracket,
  },
};

export const raku = StreamLanguage.define(rakuParser);
