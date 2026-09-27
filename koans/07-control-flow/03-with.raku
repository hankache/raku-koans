# title: with
# intro: `with` is like `if`, but it asks whether a value is defined rather than whether it is true. `without` is its opposite, and `orwith` is its `elsif`.
my $zero = 0;
my $seen = 'nothing';
if $zero { $seen = 'if' }
is $seen, ___, '0 is false, so if skips it';
with $zero { $seen = 'with' }
is $seen, ___, 'but 0 is defined, so with runs';
my Int $empty;
my $result = 'unset';
with $empty { $result = 'first' } orwith 42 { $result = 'orwith' }
is $result, ___, 'orwith tries the next value';
without $empty { $result = 'without' }
is $result, ___, 'without runs when the value is undefined';
