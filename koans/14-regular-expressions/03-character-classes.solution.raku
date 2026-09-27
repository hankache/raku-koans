is so('John123' ~~ / \d /), True, 'John123 contains a digit';
is so('John-Doe' ~~ / \s /), False, 'John-Doe contains no whitespace';
is so('John Doe' ~~ / \s /), True, 'John Doe does';
is ~('John-Doe' ~~ / \W /), '-', '\W: the first character that is not a word character';
is ~('abc 123' ~~ / \d+ /), '123', '\d+ matches a run of digits';
