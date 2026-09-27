enum Color <Red Green Blue>;
is Green.value, 1, 'values count from 0';
is Blue.key, 'Blue', 'the key is the name';
is so(Red ~~ Color), True, 'each value is of its enum type';
enum Size (S => 1, M => 5, L => 10);
is M.value, 5, 'you can choose the values';
is Size(10), L, 'and look one up by its value';
