# title: Catching exceptions
# intro: When something goes wrong, an exception is thrown and the program stops. A `try` block with a `CATCH` block inside catches it, so the program can carry on.
my Str $name;
my $message = 'all good';
try {
    $name = 123;
    CATCH {
        default {
            $message = "Can you tell us your name again?";
        }
    }
}
is $message, ___, 'assigning an Int to a Str variable threw, and CATCH handled it';
my $kind;
try {
    die 'Error !';
    CATCH {
        when X::AdHoc { $kind = 'ad hoc' }
        default       { $kind = 'something else' }
    }
}
is $kind, ___, 'CATCH picks a when by exception type, like given';
is-deeply (try { die 'oops' }), ___, 'a try without CATCH just returns Nil…';
is $!.message, ___, '…and leaves the exception in $!';
