my $var = 2;
is so($var == 1|2|3), True, '| builds an any junction';
is so(5 > all(1, 2, 3)), True, 'all: every value';
is so(3 == one(1, 3, 3)), False, 'one: exactly one value';
is so('x' eq none('a', 'b')), True, 'none: not a single value';
is so(4 == 1|2|3), False, 'four is none of them';
