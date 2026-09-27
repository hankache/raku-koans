my %capitals = UK => 'London', Germany => 'Berlin';
is %capitals<UK>, 'London', 'look up a key';
%capitals.push: (France => 'Paris');
is %capitals<France>, 'Paris', 'push adds a key/value pair';
is-deeply %capitals.keys.sort.List, ('France', 'Germany', 'UK'), 'keys lists the keys (sorted here, hashes have no order)';
is-deeply %capitals.values.sort.List, ('Berlin', 'London', 'Paris'), 'values lists the values';
is %capitals.kv.elems, 6, 'kv interleaves keys and values';
is %capitals<Spain>:exists, False, ':exists asks whether a key is there';
