# title: gather and take
# intro: `gather` collects every value that `take` hands it, even from inside called code. The result is lazy: values are only produced when asked for.
my @evens = gather { for 1..10 { take $_ if $_ %% 2 } };
is-deeply @evens, ___, 'take the even numbers';
sub produce { take 'deep' }
is-deeply (gather { produce(); take 'top' }).List, ___, 'take works from inside a called sub';
my \squares = gather { my $n = 0; loop { take $n ** 2; $n++ } };
is-deeply squares.head(4).List, ___, 'an infinite gather: only four values are ever made';
