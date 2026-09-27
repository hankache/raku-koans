my @found;
for 1..10 -> $n {
    next if $n %% 2;
    last if $n > 7;
    @found.push($n);
}
is-deeply @found, [1, 3, 5, 7], 'next skips the even numbers, last stops after 7';
my @pairs;
OUTER: for 1..3 -> $i {
    for 1..3 -> $j {
        next OUTER if $j > $i;
        @pairs.push("$i$j");
    }
}
is-deeply @pairs, ['11', '21', '22', '31', '32', '33'], 'next OUTER continues the outer loop';
my @log;
for 1..3 {
    FIRST @log.push('start');
    @log.push($_);
    LAST @log.push('end');
}
is-deeply @log, ['start', 1, 2, 3, 'end'], 'FIRST runs before the first iteration, LAST after the last';
my $cleanup = '';
{
    LEAVE $cleanup = 'done';
}
is $cleanup, 'done', 'LEAVE runs whenever a block is left';
