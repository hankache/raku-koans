# title: Unicode-aware operations
# intro: Numbers in other scripts just work. For text, `cmp` and `sort` go by code point; `unicmp` and `collate` follow the Unicode Collation Algorithm instead.
is-deeply (٤, ٥, ٦, 1, 2, 3).sort.List, ___, 'Eastern Arabic digits sort with the others';
is 1 + ٩, ___, 'and add up';
is 'a' cmp 'B', ___, 'by code point, lowercase a comes after capital B';
is 'a' unicmp 'B', ___, 'unicmp puts a before B';
is-deeply <a b c D E F>.sort.List, ___, 'sort goes by code point';
is-deeply <a b c D E F>.collate.List, ___, 'collate goes alphabetically';
