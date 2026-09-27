class X::Koan::Unenlightened is Exception {
    has $.koan;
    method message { "You have not yet understood $!koan" }
}
my &unenlightened = { X::Koan::Unenlightened.new(koan => 'junctions').throw };
throws-like &unenlightened, X::Koan::Unenlightened, 'your own exception class';
throws-like &unenlightened, X::Koan::Unenlightened, message => 'You have not yet understood junctions', 'with your own message';
my $caught;
try {
    X::Koan::Unenlightened.new(koan => 'regexes').throw;
    CATCH { default { $caught = .koan } }
}
is $caught, 'regexes', 'inside CATCH, $_ is the exception object';
my $kind;
try {
    X::Koan::Unenlightened.new(koan => 'grammars').throw;
    CATCH {
        when X::Koan::Unenlightened { $kind = 'mine' }
        default                     { $kind = 'other' }
    }
}
is $kind, 'mine', 'when picks your exception by its type';
