# title: say and print
# intro: `say` writes a line and adds a newline; `print` adds nothing. Here, `capture()` collects what the code writes, so we can test it. (`get`, `prompt`, `run` and `shell` need a real terminal, so they are not covered.)
sub capture(&code) {
    my $out = '';
    my $*OUT = class {
        method print(*@a) { $out ~= @a.join; True }
        method say(*@a) { $out ~= @a.join ~ "\n"; True }
    }.new;
    code();
    $out
}
is capture({ say 'Hello Mam.'; say 'Hello Sir.' }), ___, 'say writes each on its own line';
is capture({ print 'Hello Mam.'; print 'Hello Sir.' }), ___, 'print does not add a newline';
is capture({ say 1 + 1 }), ___, 'say prints the value of an expression';
