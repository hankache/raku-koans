# title: Exact numbers
# intro: Raku keeps fractions exact: `0.1` is stored as the fraction `1/10`, not as a binary approximation. Integers grow as large as they need to.
is 0.1 + 0.2 == 0.3, ___, 'rationals are exact';
is-deeply (1/3).WHAT, ___, 'one third is a Rat (a rational number)';
my $rat = 2.3;
is $rat.numerator, ___, '2.3 is stored as a fraction: its numerator…';
is $rat.denominator, ___, '…and its denominator';
is-deeply $rat.nude, ___, 'nude returns both';
is 2 ** 64, ___, 'integers never overflow';
is-deeply 1.5e0.WHAT, ___, 'an exponent makes a floating-point Num';
