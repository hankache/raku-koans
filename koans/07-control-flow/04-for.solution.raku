my @array = 1, 2, 3;
my @result;
for @array -> $array-item {
    @result.push($array-item * 100);
}
is-deeply @result, [100, 200, 300], 'each element times 100';
my $total = 0;
for 1..4 { $total += $_ }
is $total, 10, '$_ holds the current value';
my @pairs;
for <a 1 b 2> -> $key, $value {
    @pairs.push("$key=$value");
}
is-deeply @pairs, ['a=1', 'b=2'], 'take two values at a time';
