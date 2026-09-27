my $var = 2;
is ++$var, 3, 'prefix ++ increments, then returns the result';
is $var++, 3, 'postfix ++ returns the value, then increments';
is $var, 4, 'so now the variable holds…';
is --$var, 3, 'prefix -- decrements first';
is $var--, 3, 'postfix -- decrements afterwards';
is $var, 2, 'back where we started';
