subset Even of Int where * %% 2;
is so(4 ~~ Even), True, '4 is Even';
is so(3 ~~ Even), False, '3 is not';
sub half(Even $n) { $n div 2 }
is half(10), 5, 'a subset as a parameter type';
dies-ok { half(3) }, 'give it an odd number';
subset Name of Str where *.chars > 0;
is so('' ~~ Name), False, 'an empty string is not a Name';
