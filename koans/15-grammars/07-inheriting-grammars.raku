# title: Inheriting grammars
# intro: A grammar is a class, so it can inherit from another and override just the tokens it wants to change. `:rule<name>` starts parsing from a token other than `TOP`.
grammar Word {
    token TOP  { <word>+ % ' ' }
    token word { <[a..z]>+ }
}
grammar Shout is Word {
    token word { <[A..Z]>+ }
}
is so(Word.parse('hello world')), ___, 'lowercase words';
is so(Shout.parse('HELLO WORLD')), ___, 'Shout inherited TOP and changed word';
is so(Shout.parse('hello world')), ___, 'so lowercase no longer matches';
is ~Word.parse('hello', :rule<word>), ___, 'parse a single word, starting from the word token';
