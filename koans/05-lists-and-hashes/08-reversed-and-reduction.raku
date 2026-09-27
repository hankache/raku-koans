# title: Reversed and reduction operators
# intro: Put `R` in front of an operator to swap its operands. Wrap an operator in `[ ]` to apply it across a whole list.
is 2 R/ 3, ___, 'R/ divides the right side by the left';
is 2 R- 1, ___, 'R- subtracts the left side from the right';
is [+](1, 2, 3, 4, 5), ___, '[+] adds up a list';
is [*](1, 2, 3, 4, 5), ___, '[*] multiplies a list';
is [~]('a', 'b', 'c'), ___, 'it works with any infix operator';
is [max](3, 9, 2), ___, 'even max';
