is-deeply (٤, ٥, ٦, 1, 2, 3).sort.List, (1, 2, 3, 4, 5, 6), 'Eastern Arabic digits sort with the others';
is 1 + ٩, 10, 'and add up';
is 'a' cmp 'B', More, 'by code point, lowercase a comes after capital B';
is 'a' unicmp 'B', Less, 'unicmp puts a before B';
is-deeply <a b c D E F>.sort.List, ('D', 'E', 'F', 'a', 'b', 'c'), 'sort goes by code point';
is-deeply <a b c D E F>.collate.List, ('a', 'b', 'c', 'D', 'E', 'F'), 'collate goes alphabetically';
