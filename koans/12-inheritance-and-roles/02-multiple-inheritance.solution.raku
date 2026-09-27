class bar-chart {
    has Int @.bar-values;
    method plot { 'bars: ' ~ @.bar-values }
}
class line-chart {
    has Int @.line-values;
    method plot { 'line: ' ~ @.line-values }
}
class combo-chart is bar-chart is line-chart { }
my $combo = combo-chart.new(bar-values => [10, 9, 11], line-values => [9, 8, 10]);
is $combo.plot, 'bars: 10 9 11', 'the first parent wins, and the line is lost';
class fixed-chart is bar-chart is line-chart {
    method plot { 'bars: ' ~ @.bar-values ~ ', line: ' ~ @.line-values }
}
my $fixed = fixed-chart.new(bar-values => [10, 9, 11], line-values => [9, 8, 10]);
is $fixed.plot, 'bars: 10 9 11, line: 9 8 10', 'overriding plot shows both';
