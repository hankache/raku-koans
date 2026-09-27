grammar Greeting {
    token TOP   { <hello> ' ' <name> }
    token hello { 'Hello' | 'Hi' }
    token name  { \w+ }
}
my $m = Greeting.parse('Hello Camelia');
is so($m), True, 'it parses';
is ~$m<name>, 'Camelia', 'each token is captured by name';
is ~$m<hello>, 'Hello', 'including hello';
is-deeply Greeting.parse('Hey Camelia'), Nil, 'Hey is not a greeting this grammar knows';
is so(Greeting.subparse('Hi Camelia!!')), True, 'subparse ignores the rest';
