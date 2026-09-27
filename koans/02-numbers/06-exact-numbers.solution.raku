is 0.1 + 0.2 == 0.3, True, 'rationals are exact';
is-deeply (1/3).WHAT, Rat, 'one third is a Rat (a rational number)';
my $rat = 2.3;
is $rat.numerator, 23, '2.3 is stored as a fraction: its numerator…';
is $rat.denominator, 10, '…and its denominator';
is-deeply $rat.nude, (23, 10), 'nude returns both';
is 2 ** 64, 18446744073709551616, 'integers never overflow';
is-deeply 1.5e0.WHAT, Num, 'an exponent makes a floating-point Num';
