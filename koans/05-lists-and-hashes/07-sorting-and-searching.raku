# title: Sorting and searching
# intro: `sort`, `min` and `max` can compare by a key you give them. `first` finds the first element that matches, `grep` keeps all of them, and `classify` groups them.
my @words = <pear fig apple banana>;
is-deeply @words.sort.List, ___, 'sort alphabetically';
is-deeply @words.sort(*.chars).List, ___, 'sort by a key: the length';
is @words.max(*.chars), ___, 'the longest';
is @words.first(*.starts-with('b')), ___, 'the first that starts with b';
is @words.first(*.chars == 5, :k), ___, ':k gives its position instead';
is-deeply @words.grep(*.chars > 4).List, ___, 'grep keeps every match';
is-deeply (1..6).classify({ $_ %% 2 ?? 'even' !! 'odd' })<even>.List, ___, 'classify groups by a key';
