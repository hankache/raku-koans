# title: Feed operator
# intro: `==>` feeds the result of each step into the next, top to bottom. `<==` flows the other way.
my @array = 7, 8, 9, 0, 1, 2, 4, 3, 5, 6, 7, 8, 9;
@array ==> unique()
       ==> sort()
       ==> reverse()
       ==> my @final-array;
is-deeply @final-array, ___, 'the forward feed';
my @final-array-v2 <== reverse()
                   <== sort()
                   <== unique()
                   <== @array;
is-deeply @final-array-v2, ___, 'the backward feed ends in the same place';
