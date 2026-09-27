is-deeply [1, 2, 3], [1, 2, 3], 'is-deeply compares structures, element by element';
is-deeply { a => 1, b => 2 }, { a => 1, b => 2 }, 'hashes too';
is-approx 22 / 7, 3.14, :abs-tol(0.01), 'is-approx accepts values that are close enough';
cmp-ok 10, '>', 5, 'cmp-ok compares using the operator you name';
cmp-ok 'apple', 'lt', 'banana', 'string operators work too';
like 'enlightenment', /light/, 'like matches a string against a regex';
unlike 'enlightenment', /dark/, 'unlike wants no match at all';
