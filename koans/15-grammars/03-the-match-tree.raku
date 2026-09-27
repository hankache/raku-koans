# title: The match tree
# intro: A parse returns a tree of `Match` objects: each token's match holds the matches of the tokens it called. A token matched several times gives a list.
grammar Settings {
    rule  TOP   { <pair>* }
    rule  pair  { <key> '=' <value> }
    token key   { \w+ }
    token value { \w+ }
}
my $m = Settings.parse('colour = blue size = large');
is $m<pair>.elems, ___, '<pair>* matched twice: a list of two';
is ~$m<pair>[0]<key>, ___, 'the first pair, its key';
is ~$m<pair>[1]<value>, ___, 'the second pair, its value';
is-deeply $m<pair>.map({ ~.<key> }).List, ___, 'all the keys';
