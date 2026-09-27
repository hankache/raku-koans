my $fruit = set <apple pear fig>;
is so('fig' ∈ $fruit), True, '∈: is it an element?';
is so('kiwi' (elem) $fruit), False, '(elem) is the ASCII way to write ∈';
is-deeply (set(1, 2) ∪ set(2, 3)).keys.sort.List, (1, 2, 3), '∪ is the union';
is-deeply (set(1, 2) ∩ set(2, 3)).keys.List, (2,), '∩ is the intersection';
is-deeply (set(1, 2, 3) (-) set(2)).keys.sort.List, (1, 3), '(-) is the difference';
is so(set(1, 2) ⊆ set(1, 2, 3)), True, '⊆: is it a subset?';
is set(<a a b>).elems, 2, 'duplicates collapse';
