my @array = 0, 1, 2, 3, 4, 5;
sub is-even($var) { $var %% 2 }
is-deeply @array>>.is-prime.List, (False, False, True, True, False, True), 'is-prime on each element';
is-deeply @array>>.&is-even.List, (True, False, True, False, True, False), 'your own sub on each element';
is-deeply (<a b c>)>>.uc.List, ('A', 'B', 'C'), 'works on any list';
