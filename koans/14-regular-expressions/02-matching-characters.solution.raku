is so('Temperature: 13' ~~ m/ \: /), True, 'a backslash escapes the colon';
is so('Age = 13' ~~ m/ '=' /), True, 'single quotes work';
is so('name@company.com' ~~ m/ "@" /), True, 'and double quotes';
is ~('price: 5$' ~~ / \d '$' /), '5$', 'the match itself';
