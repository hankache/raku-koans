is so('abc' ~~ m/ a.c /), True, '. matches b';
is so('ac' ~~ m/ a.c /), False, 'but . must match something';
is so('c' ~~ m/ a?c /), True, 'a? allows no a at all';
is so('aaaaaaaaaaz' ~~ m/ a*z /), True, 'a* allows many';
is so('z' ~~ m/ a+z /), False, 'a+ wants at least one a';
is ~('aaz' ~~ m/ a+z /), 'aaz', 'the match';
