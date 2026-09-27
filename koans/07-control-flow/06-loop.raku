# title: loop
# intro: `loop` is the C-style `for` loop: an initializer, a condition, and a step.
my @numbers;
loop (my $i = 0; $i < 5; $i++) {
    @numbers.push($i);
}
is-deeply @numbers, ___, 'from 0 while less than 5';
my $n = 1;
loop {
    $n *= 2;
    last if $n > 100;
}
is $n, ___, 'loop with no parts runs until last';
