# title: Named regexes
# intro: A long regex can be broken into named pieces with `my regex name { … }`, then called as `<name>`. (This email check is only an example, not a real validator.)
my regex many-letters { <:L>+ }
my regex dot { \. }
my regex at-sign { \@ }
my regex many-letters-numbers { [<:L> | <:N>]+ }
my $email = / <many-letters> <dot> <many-letters> <at-sign> <many-letters-numbers> <dot> <many-letters> /;
is so('john.doe@perl6.org' ~~ $email), ___, 'first.last@company.org';
is so('john@perl6.org' ~~ $email), ___, 'no dot in the name';
is so('john.doe@perl6' ~~ $email), ___, 'no top-level domain';
is ~('john.doe@perl6.org' ~~ / <many-letters> /), ___, 'a named regex on its own';
