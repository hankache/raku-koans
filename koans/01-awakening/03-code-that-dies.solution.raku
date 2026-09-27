dies-ok { die 'oops' }, 'dies-ok runs a block and wants it to die';
lives-ok { 1 + 1 }, 'lives-ok wants the block to finish quietly';
eval-dies-ok '1 +', 'eval-dies-ok compiles a string: give it code that is not valid Raku';
eval-lives-ok '1 + 1', 'eval-lives-ok wants the string to compile and run';
throws-like { die 'boom' }, X::AdHoc, 'throws-like checks the type of the exception: die throws X::AdHoc';
throws-like { die 'boom' }, X::AdHoc, message => 'boom', 'and it can check the message too';
