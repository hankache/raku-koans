grammar Word {
    token TOP  { <word>+ % ' ' }
    token word { <[a..z]>+ }
}
grammar Shout is Word {
    token word { <[A..Z]>+ }
}
is so(Word.parse('hello world')), True, 'lowercase words';
is so(Shout.parse('HELLO WORLD')), True, 'Shout inherited TOP and changed word';
is so(Shout.parse('hello world')), False, 'so lowercase no longer matches';
is ~Word.parse('hello', :rule<word>), 'hello', 'parse a single word, starting from the word token';
