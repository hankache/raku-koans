# title: Multiple dispatch
# intro: `multi` declares several subs with the same name. Raku picks the one whose signature fits the arguments.
multi greet($name) {
    "Good morning $name";
}
multi greet($name, $title) {
    "Good morning $title $name";
}
is greet('Johnnie'), ___, 'one argument';
is greet('Laura', 'Mrs.'), ___, 'two arguments pick the other candidate';
multi kind(Int $n) { 'an integer' }
multi kind(Str $s) { 'a string' }
is kind(7), ___, 'types can decide too';
is kind('seven'), ___, 'the Str candidate';
