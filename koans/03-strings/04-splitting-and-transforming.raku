# title: Splitting and transforming
# intro: `split` cuts a string at a separator; `comb` keeps the pieces that match. `trans` swaps characters, `trim` removes surrounding whitespace, and `join` puts pieces back together.
is-deeply 'a,b,c'.split(',').List, ___, 'split at commas';
is-deeply 'Raku'.comb.List, ___, 'comb with no argument gives the characters';
is-deeply 'a1b22c333'.comb(/\d+/).List, ___, 'comb with a regex keeps what matches';
is 'hello'.trans('el' => 'ip'), ___, 'trans: e becomes i, l becomes p';
is 'Raku'.index('k'), ___, 'index finds a position';
is '  padded  '.trim, ___, 'trim removes the whitespace around';
is <a b c>.join('-'), ___, 'join is the opposite of split';
