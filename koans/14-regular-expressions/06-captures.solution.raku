if '2024-01-05' ~~ / (\d+) '-' (\d+) '-' (\d+) / {
    is ~$0, '2024', '$0 is the first capture';
    is ~$2, '05', '$2 is the third';
    is $/.list.elems, 3, 'three captures in all';
}
if 'colour=blue' ~~ / $<key>=\w+ '=' $<value>=\w+ / {
    is ~$<key>, 'colour', 'a named capture';
    is ~$<value>, 'blue', 'and another';
}
