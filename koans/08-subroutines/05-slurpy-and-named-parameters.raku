# title: Slurpy and named parameters
# intro: `*@` collects any number of positional arguments, `*%` any number of named ones. A named parameter starts with a colon; a `!` makes it required.
sub total(*@numbers) { [+] @numbers }
is total(1, 2, 3), ___, '*@ slurps positional arguments';
sub options(*%opts) { %opts.keys.sort.join(',') }
is options(:a, :b), ___, '*% slurps named arguments';
sub greet($name, :$greeting = 'Hello', :$loud) {
    my $text = "$greeting, $name";
    $loud ?? $text.uc !! $text;
}
is greet('Jane'), ___, 'named parameters are optional';
is greet('Jane', :greeting<Hi>), ___, 'pass one by name';
is greet('Jane', :loud), ___, ':loud passes True';
sub needs(:$name!) { $name }
dies-ok ___, 'a ! makes it required: call it without a name';
