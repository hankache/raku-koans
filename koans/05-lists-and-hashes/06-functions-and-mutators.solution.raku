my @numbers = 7, 2, 4, 9, 11, 3;
@numbers.push(99);
is-deeply @numbers, [7, 2, 4, 9, 11, 3, 99], 'push is a mutator: it changed the array';
is-deeply @numbers.sort.List, (2, 3, 4, 7, 9, 11, 99), 'sort returns a sorted list…';
is-deeply @numbers, [7, 2, 4, 9, 11, 3, 99], '…but it is a function: the array is unchanged';
@numbers.=sort;
is-deeply @numbers, [2, 3, 4, 7, 9, 11, 99], '.= made sort act as a mutator';
