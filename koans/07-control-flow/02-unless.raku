# title: unless
# intro: `unless` is `if not`. It cannot have an `else`.
my $clean-shoes = False;
my $advice = 'Looking sharp';
unless $clean-shoes {
    $advice = 'Clean your shoes';
}
is $advice, ___, 'unless runs its block when the condition is False';
my $told = 'nothing';
$told = 'Clean your shoes' unless True;
is $told, ___, 'a trailing unless';
