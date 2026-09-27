sub say-hello($name?) {
    with $name { 'Hello ' ~ $name }
    else { 'Hello Human' }
}
is say-hello(), 'Hello Human', 'an optional parameter may be left out';
is say-hello('Laura'), 'Hello Laura', 'or given';
sub greet($name = 'Matt') {
    'Hello ' ~ $name;
}
is greet(), 'Hello Matt', 'a default is used when nothing is passed';
is greet('Laura'), 'Hello Laura', 'and ignored when something is';
