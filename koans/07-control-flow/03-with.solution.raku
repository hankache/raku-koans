my $zero = 0;
my $seen = 'nothing';
if $zero { $seen = 'if' }
is $seen, 'nothing', '0 is false, so if skips it';
with $zero { $seen = 'with' }
is $seen, 'with', 'but 0 is defined, so with runs';
my Int $empty;
my $result = 'unset';
with $empty { $result = 'first' } orwith 42 { $result = 'orwith' }
is $result, 'orwith', 'orwith tries the next value';
without $empty { $result = 'without' }
is $result, 'without', 'without runs when the value is undefined';
