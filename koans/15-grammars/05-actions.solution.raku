grammar Sum {
    rule  TOP { <num> + % '+' }
    token num { \d+ }
}
class SumActions {
    method num($/) { make +$/ }
    method TOP($/) { make [+] $<num>.map(*.made) }
}
my $m = Sum.parse('1 + 2 + 3', actions => SumActions);
is $m.made, 6, 'TOP made the total';
is $m<num>[2].made, 3, 'each num made its own number';
is Sum.parse('10 + 20', actions => SumActions).made, 30, 'the same actions, another sum';
