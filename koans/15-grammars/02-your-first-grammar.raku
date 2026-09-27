# title: Your first grammar
# intro: A `grammar` is a class of named tokens and rules. `.parse` matches the whole string, starting from `TOP`; `.subparse` is happy with a prefix. A failed parse returns `Nil`.
grammar Greeting {
    token TOP   { <hello> ' ' <name> }
    token hello { 'Hello' | 'Hi' }
    token name  { \w+ }
}
my $m = Greeting.parse('Hello Camelia');
is so($m), ___, 'it parses';
is ~$m<name>, ___, 'each token is captured by name';
is ~$m<hello>, ___, 'including hello';
is-deeply Greeting.parse('Hey Camelia'), ___, 'Hey is not a greeting this grammar knows';
is so(Greeting.subparse('Hi Camelia!!')), ___, 'subparse ignores the rest';
