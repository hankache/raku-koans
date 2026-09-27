my @array = 1..10;
my @raced = @array.race.map({ $_ + 1 });
is-deeply @raced.sort.List, (2, 3, 4, 5, 6, 7, 8, 9, 10, 11), 'race: sort the results, the order is not guaranteed';
my @hypered = @array.hyper.map({ $_ * 2 });
is-deeply @hypered.List, (2, 4, 6, 8, 10, 12, 14, 16, 18, 20), 'hyper keeps the order';
is @array.race.map({ is-prime $_ }).grep(*.so).elems, 4, 'how many primes between 1 and 10?';
