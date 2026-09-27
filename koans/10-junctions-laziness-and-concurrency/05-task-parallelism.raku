# title: Task parallelism
# intro: `start` runs code in the background and immediately returns a `Promise`. `await` waits for it. A promise is `Kept` if the code succeeds and `Broken` if it throws.
my $promise = start { 21 * 2 };
is await($promise), ___, 'await returns what the code returned';
is $promise.status, ___, 'the promise was kept';
my $broken = start { die 'no' };
dies-ok ___, 'awaiting a broken promise rethrows its exception';
is $broken.status, ___, 'the promise was broken';
my @array1 = 0..9;
my @array2 = 2..11;
my $p1 = start @array1.map({ is-prime($_ + 1) }).eager;
my $p2 = start @array2.map({ is-prime($_ - 1) }).eager;
is (await $p1) eqv (await $p2), ___, 'two independent tasks, then compare the results';
