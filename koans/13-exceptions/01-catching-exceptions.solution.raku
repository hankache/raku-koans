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
is $message, "Can you tell us your name again?", 'assigning an Int to a Str variable threw, and CATCH handled it';
my $kind;
try {
    die 'Error !';
    CATCH {
        when X::AdHoc { $kind = 'ad hoc' }
        default       { $kind = 'something else' }
    }
}
is $kind, 'ad hoc', 'CATCH picks a when by exception type, like given';
is-deeply (try { die 'oops' }), Nil, 'a try without CATCH just returns Nil…';
is $!.message, 'oops', '…and leaves the exception in $!';
