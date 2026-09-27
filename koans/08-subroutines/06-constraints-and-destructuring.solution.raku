sub positive(Int $n where * > 0) { $n }
is positive(5), 5, 'five is positive';
dies-ok { positive(-1) }, 'the where clause refuses the rest: try a negative number';
sub head([$first, *@rest]) { $first }
is head([7, 8, 9]), 7, 'unpack the first element…';
sub tail([$first, *@rest]) { @rest.elems }
is tail([7, 8, 9]), 2, '…and the rest';
sub increment($x is copy) { $x++; $x }
my $v = 1;
is increment($v), 2, 'is copy lets the sub change its own copy…';
is $v, 1, '…leaving the original alone';
sub zero($x is rw) { $x = 0 }
zero($v);
is $v, 0, 'is rw changes the variable that was passed in';
