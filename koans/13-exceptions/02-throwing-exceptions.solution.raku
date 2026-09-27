throws-like { die 'Error !' }, X::AdHoc, 'die throws X::AdHoc';
throws-like { X::AdHoc.new(payload => 'Error !').throw }, X::AdHoc, message => 'Error !', 'a typed exception, thrown by hand';
throws-like { my Int $n = 'seven' }, X::TypeCheck::Assignment, 'Raku throws typed exceptions for its own errors';
my $e = X::AdHoc.new(payload => 'oops');
isa-ok $e, Exception, 'every exception is an Exception';
is $e.message, 'oops', 'and has a message';
