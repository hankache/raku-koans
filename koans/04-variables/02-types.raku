# title: Types
# intro: `.WHAT` tells you the type of a value. Put a type before a variable's name and it will only accept values of that type: Raku is gradually typed.
my $var = 'Text';
is-deeply $var.WHAT, ___, 'a string is a Str';
$var = 123;
is-deeply $var.WHAT, ___, 'an untyped variable can hold anything';
throws-like { my Int $typed = 'Text' }, ___, 'a typed variable refuses the wrong type';
my Int @numbers = 1, 2, 3;
is @numbers.of, ___, 'arrays can be typed too';
my Cool $cool = 31;
is $cool.flip, ___, 'a Cool value can be treated as a string…';
is $cool * 2, ___, '…or as a number';
