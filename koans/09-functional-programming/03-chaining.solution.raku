my @array = 7, 8, 9, 0, 1, 2, 4, 3, 5, 6, 7, 8, 9;
is-deeply reverse(sort(unique(@array))).List, (9, 8, 7, 6, 5, 4, 3, 2, 1, 0), 'nested function calls read inside out';
is-deeply @array.unique.sort.reverse.List, (9, 8, 7, 6, 5, 4, 3, 2, 1, 0), 'chained methods read left to right';
is @array.unique.elems, 10, 'how many different numbers are there?';
