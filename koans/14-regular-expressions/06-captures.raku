# title: Captures
# intro: Parentheses capture part of a match into `$0`, `$1` and so on. `$<name>=` captures under a name instead.
if '2024-01-05' ~~ / (\d+) '-' (\d+) '-' (\d+) / {
    is ~$0, ___, '$0 is the first capture';
    is ~$2, ___, '$2 is the third';
    is $/.list.elems, ___, 'three captures in all';
}
if 'colour=blue' ~~ / $<key>=\w+ '=' $<value>=\w+ / {
    is ~$<key>, ___, 'a named capture';
    is ~$<value>, ___, 'and another';
}
