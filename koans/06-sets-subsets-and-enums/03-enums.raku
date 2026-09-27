# title: Enums
# intro: `enum` declares a set of named constants. Each has a key (its name) and a value, counting from `0` unless you choose.
enum Color <Red Green Blue>;
is Green.value, ___, 'values count from 0';
is Blue.key, ___, 'the key is the name';
is so(Red ~~ Color), ___, 'each value is of its enum type';
enum Size (S => 1, M => 5, L => 10);
is M.value, ___, 'you can choose the values';
is Size(10), ___, 'and look one up by its value';
