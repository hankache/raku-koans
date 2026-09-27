# title: Matching characters
# intro: Letters, digits and `_` match themselves. Any other character must be escaped with a backslash or quoted.
is so('Temperature: 13' ~~ m/ \: /), ___, 'a backslash escapes the colon';
is so('Age = 13' ~~ m/ '=' /), ___, 'single quotes work';
is so('name@company.com' ~~ m/ "@" /), ___, 'and double quotes';
is ~('price: 5$' ~~ / \d '$' /), ___, 'the match itself';
