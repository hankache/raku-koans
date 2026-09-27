is-deeply (0..5).List, (0, 1, 2, 3, 4, 5), '.. includes both ends';
is-deeply (0..^5).List, (0, 1, 2, 3, 4), '..^ leaves out the end';
is-deeply (0^..5).List, (1, 2, 3, 4, 5), '^.. leaves out the start';
is-deeply (0^..^5).List, (1, 2, 3, 4), '^..^ leaves out both';
is-deeply (^5).List, (0, 1, 2, 3, 4), '^5 counts from zero up to, not including, 5';
is-deeply (|(1..3), 10).List, (1, 2, 3, 10), '| flattens the range into the list';
