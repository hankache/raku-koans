my regex many-letters { <:L>+ }
my regex dot { \. }
my regex at-sign { \@ }
my regex many-letters-numbers { [<:L> | <:N>]+ }
my $email = / <many-letters> <dot> <many-letters> <at-sign> <many-letters-numbers> <dot> <many-letters> /;
is so('john.doe@perl6.org' ~~ $email), True, 'first.last@company.org';
is so('john@perl6.org' ~~ $email), False, 'no dot in the name';
is so('john.doe@perl6' ~~ $email), False, 'no top-level domain';
is ~('john.doe@perl6.org' ~~ / <many-letters> /), 'john', 'a named regex on its own';
