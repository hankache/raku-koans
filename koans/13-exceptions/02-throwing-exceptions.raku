# title: Throwing exceptions
# intro: `die` throws an ad hoc exception with a message. Typed exceptions are objects: create one and call `.throw`. Raku's own errors are typed too.
throws-like { die 'Error !' }, ___, 'die throws X::AdHoc';
throws-like { X::AdHoc.new(payload => 'Error !').throw }, X::AdHoc, message => ___, 'a typed exception, thrown by hand';
throws-like { my Int $n = 'seven' }, ___, 'Raku throws typed exceptions for its own errors';
throws-like { my $n = +'abc'; $n + 1 }, ___, 'turning text that is not a number into one throws';
my $e = X::AdHoc.new(payload => 'oops');
isa-ok $e, ___, 'every exception is an Exception';
is $e.message, ___, 'and has a message';
