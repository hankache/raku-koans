# title: Functions are first-class citizens
# intro: Functions can be passed as arguments, returned from other functions and stored in variables. Prepend `&` to a sub's name to talk about the sub itself.
my @array = 1, 2, 3, 4, 5;
sub squared($x) {
    $x ** 2
}
is-deeply map(&squared, @array).List, ___, 'map is a higher order function: it takes another function';
my &f = &squared;
is f(6), ___, 'a function stored in a variable';
sub twice(&g, $x) { g(g($x)) }
is twice(&squared, 3), ___, 'a function passed as an argument';
