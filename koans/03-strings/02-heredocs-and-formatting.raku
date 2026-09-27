# title: Heredocs and formatting
# intro: `q:to/END/` starts a heredoc: the text on the following lines, up to `END`, with the common indentation removed. `sprintf` and `.fmt` format values.
my $scores = q:to/END/;
    Paul 10
    Paulie 9
    END
is $scores.lines.elems, ___, 'the heredoc holds the lines before END';
is $scores.lines[0], ___, 'the indentation is removed';
is sprintf('%s is %d', 'the answer', 42), ___, '%s formats a string, %d an integer';
is sprintf('%.2f', 3.14159), ___, '%.2f rounds to two decimals';
is sprintf('%05d', 42), ___, 'pad with zeros';
is sprintf('%-5s|', 'ab'), ___, 'pad on the right';
is 255.fmt('%x'), ___, '.fmt is sprintf as a method';
