is 2 ~~ 2, True, 'a value against a value';
is 2 ~~ Int, True, 'a value against a type';
is 'Raku' ~~ Str, True, 'a string is a Str';
is 'Raku' ~~ Int, False, 'but not an Int';
is ~('enlightenment' ~~ /light/), 'light', 'against a regex, it returns the match';
