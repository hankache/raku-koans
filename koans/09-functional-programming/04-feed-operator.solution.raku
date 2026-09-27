my @array = 7, 8, 9, 0, 1, 2, 4, 3, 5, 6, 7, 8, 9;
@array ==> unique()
       ==> sort()
       ==> reverse()
       ==> my @final-array;
is-deeply @final-array, [9, 8, 7, 6, 5, 4, 3, 2, 1, 0], 'the forward feed';
my @final-array-v2 <== reverse()
                   <== sort()
                   <== unique()
                   <== @array;
is-deeply @final-array-v2, [9, 8, 7, 6, 5, 4, 3, 2, 1, 0], 'the backward feed ends in the same place';
