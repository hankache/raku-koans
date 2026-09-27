is so('enlightenment' ~~ m/ light /), True, 'enlightenment contains light';
is so('enlightenment' ~~ /light/), True, '/…/ is the same regex without the m';
is so('enlightenment' ~~ rx/dark/), False, 'no dark here';
is so('enlightenment' ~~ / l i g h t /), True, 'spaces in the regex are ignored';
