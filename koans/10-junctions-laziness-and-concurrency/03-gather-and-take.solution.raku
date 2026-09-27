my @evens = gather { for 1..10 { take $_ if $_ %% 2 } };
is-deeply @evens, [2, 4, 6, 8, 10], 'take the even numbers';
sub produce { take 'deep' }
is-deeply (gather { produce(); take 'top' }).List, ('deep', 'top'), 'take works from inside a called sub';
my \squares = gather { my $n = 0; loop { take $n ** 2; $n++ } };
is-deeply squares.head(4).List, (0, 1, 4, 9), 'an infinite gather: only four values are ever made';
