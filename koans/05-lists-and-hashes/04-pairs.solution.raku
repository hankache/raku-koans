my $pair = name => 'Camelia';
is $pair.key, 'name', 'the key';
is $pair.value, 'Camelia', 'the value';
is-deeply (:name<Camelia>), (name => 'Camelia'), ':name<Camelia> is the same pair';
my $n = 3;
is-deeply (:$n), (n => 3), ':$n takes the key from the variable name';
is-deeply (:verbose), (verbose => True), ':flag means True…';
is-deeply (:!verbose), (verbose => False), '…and :!flag means False';
sub greet(:$name) { "Hi $name" }
is greet(:name<Jane>), 'Hi Jane', 'colon pairs pass named arguments';
