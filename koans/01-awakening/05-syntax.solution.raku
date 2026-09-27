my $monthly-salary = 100;
my $isn't = False;
is $monthly-salary * 12, 1200, 'dashes are allowed inside names';
is $isn't, False, 'so are apostrophes';
is 1 + #`(an embedded comment) 2, 3, 'an embedded comment sits inside a line';
my $count = 0;
{
    $count++;
    $count++;
}
is $count, 2, 'a block groups statements';
my $message = 'no';
$message = 'yes' if 1 < 2;
is $message, 'yes', 'a statement can end with a condition';
