# title: Anonymous functions
# intro: A pointy block, `-> $x { … }`, is a function with no name (a lambda). A bare block uses `$_`, and `*` builds a quick function of one argument.
my @array = 1, 2, 3, 4, 5;
is-deeply map(-> $x { $x ** 2 }, @array).List, ___, 'a pointy block as the argument';
my $squared = -> $x { $x ** 2 };
is $squared(9), ___, 'a pointy block stored in a variable';
is-deeply @array.map({ $_ * 10 }).List, ___, 'a bare block gets its argument in $_';
is-deeply @array.map(* + 1).List, ___, '* + 1 is a function too';
