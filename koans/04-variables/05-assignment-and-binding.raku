# title: Assignment and binding
# intro: `=` copies a value into a variable. `:=` binds, making two names refer to the same container.
my $x = 1;
my $y = $x;
$x = 2;
is $y, ___, 'assignment copies the value';
my $a;
my $b;
$b := $a;
$a = 7;
is $b, ___, 'after binding, a change through one name shows through the other';
$b = 8;
is $a, ___, 'binding works in both directions';
my Int $bound := 123;
dies-ok ___, 'a value bound directly cannot be changed';
