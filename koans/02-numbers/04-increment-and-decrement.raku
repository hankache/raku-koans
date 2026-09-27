# title: Increment and decrement
# intro: `++` and `--` add or subtract one. In front of a variable they change it first; after it, they hand back the old value and then change it.
my $var = 2;
is ++$var, ___, 'prefix ++ increments, then returns the result';
is $var++, ___, 'postfix ++ returns the value, then increments';
is $var, ___, 'so now the variable holds…';
is --$var, ___, 'prefix -- decrements first';
is $var--, ___, 'postfix -- decrements afterwards';
is $var, ___, 'back where we started';
