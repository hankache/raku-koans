# title: Categories of characters
# intro: `\d` matches a digit, `\s` whitespace, `\w` a word character (letter, digit or underscore). The uppercase versions match anything else.
is so('John123' ~~ / \d /), ___, 'John123 contains a digit';
is so('John-Doe' ~~ / \s /), ___, 'John-Doe contains no whitespace';
is so('John Doe' ~~ / \s /), ___, 'John Doe does';
is ~('John-Doe' ~~ / \W /), ___, '\W: the first character that is not a word character';
is ~('abc 123' ~~ / \d+ /), ___, '\d+ matches a run of digits';
