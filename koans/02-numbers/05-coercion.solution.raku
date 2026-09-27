is +'3', 3, '+ turns a string into a number';
is +True, 1, 'and True into 1';
is -'3', -3, '- does the same and negates';
is ?0, False, '? turns a value into True or False';
is ?9.8, True, 'any non-zero number is true';
is ?'', False, 'an empty string is false';
my $var;
is ?$var, False, 'a variable with no value is false';
is !4, False, '! coerces to a boolean and negates it';
