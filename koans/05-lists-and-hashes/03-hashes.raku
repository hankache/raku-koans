# title: Hashes
# intro: A hash, marked by the `%` sigil, maps keys to values. `<angle brackets>` look up a key that is a simple word.
my %capitals = UK => 'London', Germany => 'Berlin';
is %capitals<UK>, ___, 'look up a key';
%capitals.push: (France => 'Paris');
is %capitals<France>, ___, 'push adds a key/value pair';
is-deeply %capitals.keys.sort.List, ___, 'keys lists the keys (sorted here, hashes have no order)';
is-deeply %capitals.values.sort.List, ___, 'values lists the values';
is %capitals.kv.elems, ___, 'kv interleaves keys and values';
is %capitals<Spain>:exists, ___, ':exists asks whether a key is there';
