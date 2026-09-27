# title: Division and divisibility
# intro: Raku has an operator for most questions you would ask about dividing.
is 3 div 2, ___, 'div is integer division; it rounds down';
is 7 % 4, ___, '% gives the remainder';
is 6 %% 4, ___, '%% asks: is the left side divisible by the right?';
is 6 %% 3, ___, 'six is divisible by three';
is 6 gcd 9, ___, 'gcd: the greatest common divisor';
is 6 lcm 9, ___, 'lcm: the least common multiple';
