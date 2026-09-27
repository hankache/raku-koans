# title: Default and optional parameters
# intro: A `?` after a parameter makes it optional. `=` gives it a default value.
sub say-hello($name?) {
    with $name { 'Hello ' ~ $name }
    else { 'Hello Human' }
}
is say-hello(), ___, 'an optional parameter may be left out';
is say-hello('Laura'), ___, 'or given';
sub greet($name = 'Matt') {
    'Hello ' ~ $name;
}
is greet(), ___, 'a default is used when nothing is passed';
is greet('Laura'), ___, 'and ignored when something is';
