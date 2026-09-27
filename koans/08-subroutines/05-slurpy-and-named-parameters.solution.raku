sub total(*@numbers) { [+] @numbers }
is total(1, 2, 3), 6, '*@ slurps positional arguments';
sub options(*%opts) { %opts.keys.sort.join(',') }
is options(:a, :b), 'a,b', '*% slurps named arguments';
sub greet($name, :$greeting = 'Hello', :$loud) {
    my $text = "$greeting, $name";
    $loud ?? $text.uc !! $text;
}
is greet('Jane'), 'Hello, Jane', 'named parameters are optional';
is greet('Jane', :greeting<Hi>), 'Hi, Jane', 'pass one by name';
is greet('Jane', :loud), 'HELLO, JANE', ':loud passes True';
sub needs(:$name!) { $name }
dies-ok { needs() }, 'a ! makes it required: call it without a name';
