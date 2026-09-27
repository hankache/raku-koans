my Int $var;
is-deeply $var.WHAT, Int, 'an empty typed variable';
my $var2;
is-deeply $var2.WHAT, Any, 'an empty untyped variable';
$var2 = True;
is-deeply $var2.WHAT, Bool, 'True and False are Bool';
$var2 = Nil;
is-deeply $var2.WHAT, Any, 'Nil clears the value';
is $var2.defined, False, 'defined asks whether a variable holds a value';
