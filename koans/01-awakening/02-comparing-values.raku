# title: Comparing values
# intro: `is` compares values as strings. For structures, numbers that are only nearly equal, other operators or patterns, `Test` has more precise assertions.
is-deeply [1, 2, 3], ___, 'is-deeply compares structures, element by element';
is-deeply { a => 1, b => 2 }, ___, 'hashes too';
is-approx 22 / 7, ___, :abs-tol(0.01), 'is-approx accepts values that are close enough';
cmp-ok 10, '>', ___, 'cmp-ok compares using the operator you name';
cmp-ok 'apple', 'lt', ___, 'string operators work too';
like 'enlightenment', ___, 'like matches a string against a regex';
unlike 'enlightenment', ___, 'unlike wants no match at all';
