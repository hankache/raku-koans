# title: Your own operators
# intro: An operator is just a sub with a special name: `infix` goes between two terms, `prefix` before one, `postfix` after one.
sub infix:<±>($a, $b) { ($a - $b, $a + $b) }
is-deeply (10 ± 1).List, ___, 'a new infix operator';
sub postfix:<!>($n) { [*] 1..$n }
is 5!, ___, 'factorial as a postfix operator';
sub prefix:<√>($n) { $n.sqrt }
is √16, ___, 'a prefix operator';
sub infix:<avg>($a, $b) { ($a + $b) / 2 }
is 3 avg 5, ___, 'operators can be words too';
