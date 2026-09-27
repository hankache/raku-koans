sub say-hello(Str $name) {
    'Hello ' ~ $name ~ '!!!!';
}
is say-hello('Paul'), 'Hello Paul!!!!', 'a string argument fits';
is say-hello('Paula'), 'Hello Paula!!!!', 'another one';
is &say-hello.arity, 1, 'arity is how many arguments it needs';
dies-ok { say-hello(42) }, 'an Int does not fit a Str parameter: call it with a number';
