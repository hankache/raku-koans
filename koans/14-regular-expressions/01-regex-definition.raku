# title: Regex definition
# intro: A regex is a pattern, written `/…/`, `m/…/` or `rx/…/`. Smartmatch a string against it with `~~`. Whitespace inside a regex is ignored.
is so('enlightenment' ~~ m/ light /), ___, 'enlightenment contains light';
is so('enlightenment' ~~ /light/), ___, '/…/ is the same regex without the m';
is so('enlightenment' ~~ rx/dark/), ___, 'no dark here';
is so('enlightenment' ~~ / l i g h t /), ___, 'spaces in the regex are ignored';
