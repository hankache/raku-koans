# title: Actions
# intro: An actions class has a method for each token you care about. As the grammar matches, each method runs and can `make` a value; `.made` reads it back.
grammar Sum {
    rule  TOP { <num> + % '+' }
    token num { \d+ }
}
class SumActions {
    method num($/) { make +$/ }
    method TOP($/) { make [+] $<num>.map(*.made) }
}
my $m = Sum.parse('1 + 2 + 3', actions => SumActions);
is $m.made, ___, 'TOP made the total';
is $m<num>[2].made, ___, 'each num made its own number';
is Sum.parse('10 + 20', actions => SumActions).made, ___, 'the same actions, another sum';
