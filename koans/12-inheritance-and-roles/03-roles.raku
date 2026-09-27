# title: Roles
# intro: A `role` is a bundle of attributes and methods that classes can do. Unlike parents, conflicting roles are an error you must resolve.
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
is $combo.plot, ___, 'the class resolves the conflict';
does-ok $combo, ___, 'it does both roles';
eval-dies-ok ___, 'two roles with the same method and no override will not compile';
