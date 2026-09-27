# title: Your own exceptions
# intro: Make your own exception class by inheriting from `Exception` and giving it a `message` method. `CATCH` can then tell it apart from others.
class X::Koan::Unenlightened is Exception {
    has $.koan;
    method message { "You have not yet understood $!koan" }
}
my &unenlightened = { X::Koan::Unenlightened.new(koan => 'junctions').throw };
throws-like &unenlightened, ___, 'your own exception class';
throws-like &unenlightened, X::Koan::Unenlightened, message => ___, 'with your own message';
my $caught;
try {
    X::Koan::Unenlightened.new(koan => 'regexes').throw;
    CATCH { default { $caught = .koan } }
}
is $caught, ___, 'inside CATCH, $_ is the exception object';
my $kind;
try {
    X::Koan::Unenlightened.new(koan => 'grammars').throw;
    CATCH {
        when X::Koan::Unenlightened { $kind = 'mine' }
        default                     { $kind = 'other' }
    }
}
is $kind, ___, 'when picks your exception by its type';
