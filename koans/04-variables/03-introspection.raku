# title: Introspection
# intro: An empty variable's type is the one it was declared with, or `Any`. Assigning `Nil` empties a variable again.
my Int $var;
is-deeply $var.WHAT, ___, 'an empty typed variable';
my $var2;
is-deeply $var2.WHAT, ___, 'an empty untyped variable';
$var2 = True;
is-deeply $var2.WHAT, ___, 'True and False are Bool';
$var2 = Nil;
is-deeply $var2.WHAT, ___, 'Nil clears the value';
is $var2.defined, ___, 'defined asks whether a variable holds a value';
