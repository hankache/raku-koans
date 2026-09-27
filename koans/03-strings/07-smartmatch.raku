# title: Smartmatch
# intro: `~~` compares a value against almost anything: another value, a type, or a regex.
is 2 ~~ 2, ___, 'a value against a value';
is 2 ~~ Int, ___, 'a value against a type';
is 'Raku' ~~ Str, ___, 'a string is a Str';
is 'Raku' ~~ Int, ___, 'but not an Int';
is ~('enlightenment' ~~ /light/), ___, 'against a regex, it returns the match';
