# title: Multiple inheritance
# intro: A class can inherit from several parents. If two parents have a method with the same name, one silently wins, unless the child overrides it.
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
is $combo.plot, ___, 'the first parent wins, and the line is lost';
class fixed-chart is bar-chart is line-chart {
    method plot { 'bars: ' ~ @.bar-values ~ ', line: ' ~ @.line-values }
}
my $fixed = fixed-chart.new(bar-values => [10, 9, 11], line-values => [9, 8, 10]);
is $fixed.plot, ___, 'overriding plot shows both';
