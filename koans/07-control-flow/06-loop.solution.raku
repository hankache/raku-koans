my @numbers;
loop (my $i = 0; $i < 5; $i++) {
    @numbers.push($i);
}
is-deeply @numbers, [0, 1, 2, 3, 4], 'from 0 while less than 5';
my $n = 1;
loop {
    $n *= 2;
    last if $n > 100;
}
is $n, 128, 'loop with no parts runs until last';
