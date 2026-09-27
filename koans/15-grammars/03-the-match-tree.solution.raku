grammar Settings {
    rule  TOP   { <pair>* }
    rule  pair  { <key> '=' <value> }
    token key   { \w+ }
    token value { \w+ }
}
my $m = Settings.parse('colour = blue size = large');
is $m<pair>.elems, 2, '<pair>* matched twice: a list of two';
is ~$m<pair>[0]<key>, 'colour', 'the first pair, its key';
is ~$m<pair>[1]<value>, 'large', 'the second pair, its value';
is-deeply $m<pair>.map({ ~.<key> }).List, ('colour', 'size'), 'all the keys';
