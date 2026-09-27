# title: String methods
# intro: Strings are objects, and they come with plenty of methods.
my $s = 'path to enlightenment';
is $s.chars, ___, 'how many characters?';
is $s.uc, ___, 'uppercase';
is $s.tc, ___, 'title case: the first letter';
is $s.flip, ___, 'backwards';
is $s.words.elems, ___, 'how many words?';
is $s.substr(0, 4), ___, 'take the start';
is $s.contains('light'), ___, 'does it contain light?';
is $s.starts-with('path'), ___, 'does it start with path?';
