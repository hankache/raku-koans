my $s = 'path to enlightenment';
is $s.chars, 21, 'how many characters?';
is $s.uc, 'PATH TO ENLIGHTENMENT', 'uppercase';
is $s.tc, 'Path to enlightenment', 'title case: the first letter';
is $s.flip, 'tnemnethgilne ot htap', 'backwards';
is $s.words.elems, 3, 'how many words?';
is $s.substr(0, 4), 'path', 'take the start';
is $s.contains('light'), True, 'does it contain light?';
is $s.starts-with('path'), True, 'does it start with path?';
