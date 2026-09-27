# title: Data parallelism
# intro: `race` and `hyper` let `map` work on several elements at the same time. `race` may return results in any order; `hyper` keeps the original order.
my @array = 1..10;
my @raced = @array.race.map({ $_ + 1 });
is-deeply @raced.sort.List, ___, 'race: sort the results, the order is not guaranteed';
my @hypered = @array.hyper.map({ $_ * 2 });
is-deeply @hypered.List, ___, 'hyper keeps the order';
is @array.race.map({ is-prime $_ }).grep(*.so).elems, ___, 'how many primes between 1 and 10?';
