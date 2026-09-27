# title: Pairs
# intro: A `Pair` joins a key and a value. The colon forms are everywhere in Raku: `:key<value>`, `:$variable` and `:flag`. Wrap a pair in parentheses when you pass it as a value, or it becomes a named argument.
my $pair = name => 'Camelia';
is $pair.key, ___, 'the key';
is $pair.value, ___, 'the value';
is-deeply (:name<Camelia>), ___, ':name<Camelia> is the same pair';
my $n = 3;
is-deeply (:$n), ___, ':$n takes the key from the variable name';
is-deeply (:verbose), ___, ':flag means True…';
is-deeply (:!verbose), ___, '…and :!flag means False';
sub greet(:$name) { "Hi $name" }
is greet(:name<Jane>), ___, 'colon pairs pass named arguments';
