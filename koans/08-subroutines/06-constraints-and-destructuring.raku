# title: Constraints and destructuring
# intro: `where` adds a condition to a parameter. A signature can also unpack an array argument. Parameters are read-only unless marked `is copy` or `is rw`.
sub positive(Int $n where * > 0) { $n }
is positive(5), ___, 'five is positive';
dies-ok ___, 'the where clause refuses the rest: try a negative number';
sub head([$first, *@rest]) { $first }
is head([7, 8, 9]), ___, 'unpack the first element…';
sub tail([$first, *@rest]) { @rest.elems }
is tail([7, 8, 9]), ___, '…and the rest';
sub increment($x is copy) { $x++; $x }
my $v = 1;
is increment($v), ___, 'is copy lets the sub change its own copy…';
is $v, ___, '…leaving the original alone';
sub zero($x is rw) { $x = 0 }
zero($v);
is $v, ___, 'is rw changes the variable that was passed in';
