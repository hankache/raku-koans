is-deeply (1 ... 10).List, (1, 2, 3, 4, 5, 6, 7, 8, 9, 10), 'the default generator adds one';
is-deeply (1 ... Inf)[^5], (1, 2, 3, 4, 5), 'an infinite list: take only what you need';
is-deeply (0, 2 ... 10).List, (0, 2, 4, 6, 8, 10), 'the generator (+2) is deduced';
is-deeply (0, { $_ + 3 } ... 12).List, (0, 3, 6, 9, 12), 'an explicit generator';
is-deeply (0, { $_ + 3 } ...^ * > 10).List, (0, 3, 6, 9), '...^ * > 10: stop before the first value above ten';
