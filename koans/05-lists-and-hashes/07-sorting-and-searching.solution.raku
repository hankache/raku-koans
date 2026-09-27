my @words = <pear fig apple banana>;
is-deeply @words.sort.List, ('apple', 'banana', 'fig', 'pear'), 'sort alphabetically';
is-deeply @words.sort(*.chars).List, ('fig', 'pear', 'apple', 'banana'), 'sort by a key: the length';
is @words.max(*.chars), 'banana', 'the longest';
is @words.first(*.starts-with('b')), 'banana', 'the first that starts with b';
is @words.first(*.chars == 5, :k), 2, ':k gives its position instead';
is-deeply @words.grep(*.chars > 4).List, ('apple', 'banana'), 'grep keeps every match';
is-deeply (1..6).classify({ $_ %% 2 ?? 'even' !! 'odd' })<even>.List, (2, 4, 6), 'classify groups by a key';
