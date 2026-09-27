# title: Hyper operator
# intro: `>>.` calls a method on every element of a list. Prepend `&` to call your own sub the same way.
my @array = 0, 1, 2, 3, 4, 5;
sub is-even($var) { $var %% 2 }
is-deeply @array>>.is-prime.List, ___, 'is-prime on each element';
is-deeply @array>>.&is-even.List, ___, 'your own sub on each element';
is-deeply (<a b c>)>>.uc.List, ___, 'works on any list';
