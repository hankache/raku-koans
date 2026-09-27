# title: Wildcards and quantifiers
# intro: `.` matches any single character. `?` means zero or one time, `*` zero or more, `+` one or more.
is so('abc' ~~ m/ a.c /), ___, '. matches b';
is so('ac' ~~ m/ a.c /), ___, 'but . must match something';
is so('c' ~~ m/ a?c /), ___, 'a? allows no a at all';
is so('aaaaaaaaaaz' ~~ m/ a*z /), ___, 'a* allows many';
is so('z' ~~ m/ a+z /), ___, 'a+ wants at least one a';
is ~('aaz' ~~ m/ a+z /), ___, 'the match';
