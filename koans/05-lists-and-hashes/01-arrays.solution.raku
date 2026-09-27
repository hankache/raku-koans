my @animals = 'camel', 'vicuña', 'llama';
is @animals.elems, 3, 'elems counts the elements';
is @animals[0], 'camel', 'the first animal';
@animals.push('owl');
is @animals.elems, 4, 'push adds to the end';
is @animals.pop, 'owl', 'pop removes the last element and returns it';
is-deeply @animals.splice(1, 2), ['vicuña', 'llama'], 'splice(1, 2) removes two elements starting at position 1';
is-deeply @animals, ['camel'], 'and one animal is left';
