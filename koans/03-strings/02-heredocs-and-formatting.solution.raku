my $scores = q:to/END/;
    Paul 10
    Paulie 9
    END
is $scores.lines.elems, 2, 'the heredoc holds the lines before END';
is $scores.lines[0], 'Paul 10', 'the indentation is removed';
is sprintf('%s is %d', 'the answer', 42), 'the answer is 42', '%s formats a string, %d an integer';
is sprintf('%.2f', 3.14159), '3.14', '%.2f rounds to two decimals';
is sprintf('%05d', 42), '00042', 'pad with zeros';
is sprintf('%-5s|', 'ab'), 'ab   |', 'pad on the right';
is 255.fmt('%x'), 'ff', '.fmt is sprintf as a method';
