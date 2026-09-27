# title: Sets
# intro: A set holds each value once and answers membership questions. Set operators have Unicode forms (`∈` `∪` `∩` `⊆`) and ASCII ones: `(elem)` `(|)` `(&)` `(<=)` and `(-)`.
my $fruit = set <apple pear fig>;
is so('fig' ∈ $fruit), ___, '∈: is it an element?';
is so('kiwi' (elem) $fruit), ___, '(elem) is the ASCII way to write ∈';
is-deeply (set(1, 2) ∪ set(2, 3)).keys.sort.List, ___, '∪ is the union';
is-deeply (set(1, 2) ∩ set(2, 3)).keys.List, ___, '∩ is the intersection';
is-deeply (set(1, 2, 3) (-) set(2)).keys.sort.List, ___, '(-) is the difference';
is so(set(1, 2) ⊆ set(1, 2, 3)), ___, '⊆: is it a subset?';
is set(<a a b>).elems, ___, 'duplicates collapse';
