# title: Code that dies
# intro: Some assertions take code instead of a value. A block is code in curly braces `{}`; a string can be compiled as code too.
dies-ok ___, 'dies-ok runs a block and wants it to die';
lives-ok ___, 'lives-ok wants the block to finish quietly';
eval-dies-ok ___, 'eval-dies-ok compiles a string: give it code that is not valid Raku';
eval-lives-ok ___, 'eval-lives-ok wants the string to compile and run';
throws-like { die 'boom' }, ___, 'throws-like checks the type of the exception: die throws X::AdHoc';
throws-like { die 'boom' }, X::AdHoc, message => ___, 'and it can check the message too';
