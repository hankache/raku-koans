# title: Coercion
# intro: Prefix operators can turn a value into a number (`+` and `-`) or a boolean (`?` and `!`).
is +'3', ___, '+ turns a string into a number';
is +True, ___, 'and True into 1';
is -'3', ___, '- does the same and negates';
is ?0, ___, '? turns a value into True or False';
is ?9.8, ___, 'any non-zero number is true';
is ?'', ___, 'an empty string is false';
my $var;
is ?$var, ___, 'a variable with no value is false';
is !4, ___, '! coerces to a boolean and negates it';
