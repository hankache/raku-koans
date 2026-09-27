# title: Quoting and interpolation
# intro: Single quotes take text literally; double quotes interpolate variables, blocks and escapes like `\t`. `q{ }` and `qq{ }` do the same with any delimiter.
my $name = 'Camelia';
is 'Hello, $name', ___, 'single quotes do not interpolate';
is "Hello, $name", ___, 'double quotes do';
is "1 + 1 = {1 + 1}", ___, 'blocks interpolate too';
my @list = 1, 2, 3;
is "Items: @list[]", ___, 'an array interpolates with []';
is "Don't", ___, 'use double quotes when the text has an apostrophe';
is q{it's here}, ___, 'q{ } quotes like single quotes, with any delimiter';
is qq[Hi $name], ___, 'qq[ ] quotes like double quotes';
is "a\tb".chars, ___, '\t is a single tab character';
