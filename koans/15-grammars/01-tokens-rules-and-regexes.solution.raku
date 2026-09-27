is so('aaa' ~~ / a+ a /), True, 'a regex backtracks: a+ gives the last a back';
my token greedy { a+ a }
is so('aaa' ~~ / <greedy> /), False, 'a token does not: a+ keeps every a';
my token squashed { hello world }
is so('helloworld' ~~ / ^ <squashed> $ /), True, 'in a token, spaces in the pattern are ignored';
my rule spaced { hello world }
is so('hello   world' ~~ / ^ <spaced> $ /), True, 'in a rule, they match whitespace';
