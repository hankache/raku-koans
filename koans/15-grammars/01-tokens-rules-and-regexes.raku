# title: Tokens, rules and regexes
# intro: A `regex` backtracks: it gives characters back to find a match. A `token` never does (it ratchets). A `rule` is a token where the spaces in the pattern match whitespace.
is so('aaa' ~~ / a+ a /), ___, 'a regex backtracks: a+ gives the last a back';
my token greedy { a+ a }
is so('aaa' ~~ / <greedy> /), ___, 'a token does not: a+ keeps every a';
my token squashed { hello world }
is so('helloworld' ~~ / ^ <squashed> $ /), ___, 'in a token, spaces in the pattern are ignored';
my rule spaced { hello world }
is so('hello   world' ~~ / ^ <spaced> $ /), ___, 'in a rule, they match whitespace';
