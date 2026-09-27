# title: Repetition and separators
# intro: Quantifiers repeat a token: `*`, `+` and `**` with a count. `%` puts a separator between the repetitions.
grammar CSV {
    token TOP  { <cell>+ % ',' }
    token cell { \w+ }
}
my $row = CSV.parse('a,b,c');
is $row<cell>.elems, ___, 'three cells between two commas';
is-deeply $row<cell>.map(~*).List, ___, 'the cells';
is-deeply CSV.parse('a,,c'), ___, 'an empty cell does not match \w+';
grammar Code {
    token TOP   { <digit> ** 4 }
    token digit { \d }
}
is so(Code.parse('1234')), ___, '** 4: exactly four digits';
is so(Code.parse('123')), ___, 'three is not enough';
