sub infix:<±>($a, $b) { ($a - $b, $a + $b) }
is-deeply (10 ± 1).List, (9, 11), 'a new infix operator';
sub postfix:<!>($n) { [*] 1..$n }
is 5!, 120, 'factorial as a postfix operator';
sub prefix:<√>($n) { $n.sqrt }
is √16, 4, 'a prefix operator';
sub infix:<avg>($a, $b) { ($a + $b) / 2 }
is 3 avg 5, 4, 'operators can be words too';
