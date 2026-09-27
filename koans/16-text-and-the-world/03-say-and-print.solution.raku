sub capture(&code) {
    my $out = '';
    my $*OUT = class {
        method print(*@a) { $out ~= @a.join; True }
        method say(*@a) { $out ~= @a.join ~ "\n"; True }
    }.new;
    code();
    $out
}
is capture({ say 'Hello Mam.'; say 'Hello Sir.' }), "Hello Mam.\nHello Sir.\n", 'say writes each on its own line';
is capture({ print 'Hello Mam.'; print 'Hello Sir.' }), 'Hello Mam.Hello Sir.', 'print does not add a newline';
is capture({ say 1 + 1 }), "2\n", 'say prints the value of an expression';
