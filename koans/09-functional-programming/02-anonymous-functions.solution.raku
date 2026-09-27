my @array = 1, 2, 3, 4, 5;
is-deeply map(-> $x { $x ** 2 }, @array).List, (1, 4, 9, 16, 25), 'a pointy block as the argument';
my $squared = -> $x { $x ** 2 };
is $squared(9), 81, 'a pointy block stored in a variable';
is-deeply @array.map({ $_ * 10 }).List, (10, 20, 30, 40, 50), 'a bare block gets its argument in $_';
is-deeply @array.map(* + 1).List, (2, 3, 4, 5, 6), '* + 1 is a function too';
