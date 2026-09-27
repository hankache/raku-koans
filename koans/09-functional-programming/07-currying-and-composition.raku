# title: Currying and composition
# intro: `.assuming` fixes some of a function's arguments and returns a new function. `∘` composes two functions into one. `$^a` and `$^b` are placeholder parameters.
sub add($a, $b) { $a + $b }
my &add-ten = &add.assuming(10);
is add-ten(5), ___, 'assuming fixes the first argument';
my &double = * * 2;
my &inc = * + 1;
is (&inc ∘ &double)(5), ___, 'f ∘ g applies g first, then f';
is (&double ∘ &inc)(5), ___, 'so the order matters';
is-deeply (1, 5, 3).sort({ $^b <=> $^a }).List, ___, '$^a and $^b take the arguments in alphabetical order';
