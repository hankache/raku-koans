is-deeply (1, 2 Z 3, 4).List, ((1, 3), (2, 4)), 'Z zips two lists into pairs';
is-deeply (1, 2 Z+ 10, 20).List, (11, 22), 'Z+ zips with addition';
is-deeply (<a b> X~ <1 2>).List, ('a1', 'a2', 'b1', 'b2'), 'X~ joins every combination';
is-deeply (1, 2 X* 10).List, (10, 20), 'X* multiplies every combination';
my $x = 5;
$x max= 9;
is $x, 9, 'max= keeps the larger value';
is-deeply ([\+] 1..4).List, (1, 3, 6, 10), '[\+] keeps the running totals';
