my $clean-shoes = False;
my $advice = 'Looking sharp';
unless $clean-shoes {
    $advice = 'Clean your shoes';
}
is $advice, 'Clean your shoes', 'unless runs its block when the condition is False';
my $told = 'nothing';
$told = 'Clean your shoes' unless True;
is $told, 'nothing', 'a trailing unless';
