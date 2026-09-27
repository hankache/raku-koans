# title: Junctions
# intro: A junction is a superposition of values. `1|2|3` means "any of 1, 2 or 3"; operations on it apply to every value at once. `so` collapses the result to a single `Bool`.
my $var = 2;
is so($var == 1|2|3), ___, '| builds an any junction';
is so(5 > all(1, 2, 3)), ___, 'all: every value';
is so(3 == one(1, 3, 3)), ___, 'one: exactly one value';
is so('x' eq none('a', 'b')), ___, 'none: not a single value';
is so(4 == 1|2|3), ___, 'four is none of them';
