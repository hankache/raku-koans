is-deeply 'a,b,c'.split(',').List, ('a', 'b', 'c'), 'split at commas';
is-deeply 'Raku'.comb.List, ('R', 'a', 'k', 'u'), 'comb with no argument gives the characters';
is-deeply 'a1b22c333'.comb(/\d+/).List, ('1', '22', '333'), 'comb with a regex keeps what matches';
is 'hello'.trans('el' => 'ip'), 'hippo', 'trans: e becomes i, l becomes p';
is 'Raku'.index('k'), 2, 'index finds a position';
is '  padded  '.trim, 'padded', 'trim removes the whitespace around';
is <a b c>.join('-'), 'a-b-c', 'join is the opposite of split';
