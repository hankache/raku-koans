grammar CSV {
    token TOP  { <cell>+ % ',' }
    token cell { \w+ }
}
my $row = CSV.parse('a,b,c');
is $row<cell>.elems, 3, 'three cells between two commas';
is-deeply $row<cell>.map(~*).List, ('a', 'b', 'c'), 'the cells';
is-deeply CSV.parse('a,,c'), Nil, 'an empty cell does not match \w+';
grammar Code {
    token TOP   { <digit> ** 4 }
    token digit { \d }
}
is so(Code.parse('1234')), True, '** 4: exactly four digits';
is so(Code.parse('123')), False, 'three is not enough';
