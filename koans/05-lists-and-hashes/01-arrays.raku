# title: Arrays
# intro: An array, marked by the `@` sigil, holds a list of values. Positions start at zero.
my @animals = 'camel', 'vicuña', 'llama';
is @animals.elems, ___, 'elems counts the elements';
is @animals[0], ___, 'the first animal';
@animals.push('owl');
is @animals.elems, ___, 'push adds to the end';
is @animals.pop, ___, 'pop removes the last element and returns it';
is-deeply @animals.splice(1, 2), ___, 'splice(1, 2) removes two elements starting at position 1';
is-deeply @animals, ___, 'and one animal is left';
