# title: Functions and mutators
# intro: A function leaves its object alone and returns a new value. A mutator changes the object. `.=` turns a function into a mutator.
my @numbers = 7, 2, 4, 9, 11, 3;
@numbers.push(99);
is-deeply @numbers, ___, 'push is a mutator: it changed the array';
is-deeply @numbers.sort.List, ___, 'sort returns a sorted list…';
is-deeply @numbers, ___, '…but it is a function: the array is unchanged';
@numbers.=sort;
is-deeply @numbers, ___, '.= made sort act as a mutator';
