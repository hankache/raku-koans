multi greet($name) {
    "Good morning $name";
}
multi greet($name, $title) {
    "Good morning $title $name";
}
is greet('Johnnie'), 'Good morning Johnnie', 'one argument';
is greet('Laura', 'Mrs.'), 'Good morning Mrs. Laura', 'two arguments pick the other candidate';
multi kind(Int $n) { 'an integer' }
multi kind(Str $s) { 'a string' }
is kind(7), 'an integer', 'types can decide too';
is kind('seven'), 'a string', 'the Str candidate';
