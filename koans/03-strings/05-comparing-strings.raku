# title: Comparing strings
# intro: Strings have their own comparison operators, spelled with letters. `leg` is the string version of `<=>`; `cmp` picks the right comparison for whatever you give it.
is 'John' eq 'John', ___, 'eq string equality';
is 'John' ne 'Jane', ___, 'ne string inequality';
is 'a' lt 'b', ___, 'lt less than';
is 'a' gt 'b', ___, 'gt greater than';
is 'a' le 'a', ___, 'le less than or equal';
is 'a' leg 'b', ___, 'leg compares strings three ways';
is 'c' leg 'b', ___, 'c comes after b';
is 3.5 cmp 2.6, ___, 'cmp compares numbers as numbers';
