# title: Chaining
# intro: Method calls can be chained, so the result of one flows into the next without nesting.
my @array = 7, 8, 9, 0, 1, 2, 4, 3, 5, 6, 7, 8, 9;
is-deeply reverse(sort(unique(@array))).List, ___, 'nested function calls read inside out';
is-deeply @array.unique.sort.reverse.List, ___, 'chained methods read left to right';
is @array.unique.elems, ___, 'how many different numbers are there?';
