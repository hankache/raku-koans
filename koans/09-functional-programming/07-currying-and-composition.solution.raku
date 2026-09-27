sub add($a, $b) { $a + $b }
my &add-ten = &add.assuming(10);
is add-ten(5), 15, 'assuming fixes the first argument';
my &double = * * 2;
my &inc = * + 1;
is (&inc ∘ &double)(5), 11, 'f ∘ g applies g first, then f';
is (&double ∘ &inc)(5), 12, 'so the order matters';
is-deeply (1, 5, 3).sort({ $^b <=> $^a }).List, (5, 3, 1), '$^a and $^b take the arguments in alphabetical order';
