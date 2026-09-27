# title: Signature
# intro: The parameters a sub declares, and their types, make up its signature. Arguments that do not fit are refused.
sub say-hello(Str $name) {
    'Hello ' ~ $name ~ '!!!!';
}
is say-hello('Paul'), ___, 'a string argument fits';
is say-hello('Paula'), ___, 'another one';
is &say-hello.arity, ___, 'arity is how many arguments it needs';
dies-ok ___, 'an Int does not fit a Str parameter: call it with a number';
