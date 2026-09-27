# title: Ranges
# intro: `..` builds a range. A `^` on either side leaves that end out. `^5` is short for `0..^5`, and a prefix `|` flattens a range into the list around it.
is-deeply (0..5).List, ___, '.. includes both ends';
is-deeply (0..^5).List, ___, '..^ leaves out the end';
is-deeply (0^..5).List, ___, '^.. leaves out the start';
is-deeply (0^..^5).List, ___, '^..^ leaves out both';
is-deeply (^5).List, ___, '^5 counts from zero up to, not including, 5';
is-deeply (|(1..3), 10).List, ___, '| flattens the range into the list';
