my @array = 1, 2, 3, 4, 5;
sub squared($x) {
    $x ** 2
}
is-deeply map(&squared, @array).List, (1, 4, 9, 16, 25), 'map is a higher order function: it takes another function';
my &f = &squared;
is f(6), 36, 'a function stored in a variable';
sub twice(&g, $x) { g(g($x)) }
is twice(&squared, 3), 81, 'a function passed as an argument';
