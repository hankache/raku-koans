# title: Scalars and sigils
# intro: A sigil tells you what a variable holds: `$` one value, `@` an ordered list, `%` key/value pairs, `&` code.
my $scalar = 'one value';
my @array = 1, 2, 3;
my %hash = a => 1;
my &code = { 'ran' };
is-deeply $scalar.WHAT, ___, '$ holds a single value';
is-deeply @array.WHAT, ___, '@ holds an Array';
is-deeply %hash.WHAT, ___, '% holds a Hash';
is code(), ___, '& holds code you can call';
my $list = (1, 2, 3);
is $list.elems, ___, 'a scalar can hold a whole list, as one item';
