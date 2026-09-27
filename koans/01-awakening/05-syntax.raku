# title: Syntax
# intro: Statements end with a semicolon; a block groups them in `{ }`. Identifiers may contain dashes and apostrophes. A comment runs to the end of the line, or sits inside one with ``#`( )``.
my $monthly-salary = 100;
my $isn't = False;
is $monthly-salary * 12, ___, 'dashes are allowed inside names';
is $isn't, ___, 'so are apostrophes';
is 1 + #`(an embedded comment) 2, ___, 'an embedded comment sits inside a line';
my $count = 0;
{
    $count++;
    $count++;
}
is $count, ___, 'a block groups statements';
my $message = 'no';
$message = 'yes' if 1 < 2;
is $message, ___, 'a statement can end with a condition';
