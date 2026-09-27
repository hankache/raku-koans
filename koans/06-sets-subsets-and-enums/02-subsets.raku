# title: Subsets
# intro: `subset` declares a new type from an existing one plus a condition. It works anywhere a type does, such as in a signature.
subset Even of Int where * %% 2;
is so(4 ~~ Even), ___, '4 is Even';
is so(3 ~~ Even), ___, '3 is not';
sub half(Even $n) { $n div 2 }
is half(10), ___, 'a subset as a parameter type';
dies-ok ___, 'give it an odd number';
subset Name of Str where *.chars > 0;
is so('' ~~ Name), ___, 'an empty string is not a Name';
