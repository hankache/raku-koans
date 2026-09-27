# title: Meta-operators
# intro: A meta-operator makes a new operator from an existing one. `Z` zips two lists, `X` crosses them, and either can carry an operator, like `Z+` or `X~`. `op=` updates a variable in place.
is-deeply (1, 2 Z 3, 4).List, ___, 'Z zips two lists into pairs';
is-deeply (1, 2 Z+ 10, 20).List, ___, 'Z+ zips with addition';
is-deeply (<a b> X~ <1 2>).List, ___, 'X~ joins every combination';
is-deeply (1, 2 X* 10).List, ___, 'X* multiplies every combination';
my $x = 5;
$x max= 9;
is $x, ___, 'max= keeps the larger value';
is-deeply ([\+] 1..4).List, ___, '[\+] keeps the running totals';
