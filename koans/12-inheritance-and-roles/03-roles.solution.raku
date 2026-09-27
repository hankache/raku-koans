role bar-chart {
    has Int @.bar-values;
    method plot { 'bars: ' ~ @.bar-values }
}
role line-chart {
    has Int @.line-values;
    method plot { 'line: ' ~ @.line-values }
}
class combo-chart does bar-chart does line-chart {
    method plot { 'bars: ' ~ @.bar-values ~ ', line: ' ~ @.line-values }
}
my $combo = combo-chart.new(bar-values => [10, 9], line-values => [9, 8]);
is $combo.plot, 'bars: 10 9, line: 9 8', 'the class resolves the conflict';
does-ok $combo, bar-chart, 'it does both roles';
eval-dies-ok 'role A { method m {} }; role B { method m {} }; class C does A does B { }', 'two roles with the same method and no override will not compile';
