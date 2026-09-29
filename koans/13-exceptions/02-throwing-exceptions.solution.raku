throws-like { die 'Error !' }, X::AdHoc, 'die throws X::AdHoc';
throws-like { X::AdHoc.new(payload => 'Error !').throw }, X::AdHoc, message => 'Error !', 'a typed exception, thrown by hand';
throws-like { my Int $n = 'seven' }, X::TypeCheck::Assignment, 'Raku throws typed exceptions for its own errors';
throws-like { my $n = +'abc'; $n + 1 }, X::Str::Numeric, 'turning text that is not a number into one throws';
my $e = X::AdHoc.new(payload => 'oops');
isa-ok $e, Exception, 'every exception is an Exception';
is $e.message, 'oops', 'and has a message';
