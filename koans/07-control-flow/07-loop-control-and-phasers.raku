# title: Loop control and phasers
# intro: `next` skips to the next iteration and `last` leaves the loop. A label lets them act on an outer loop. Phasers such as `FIRST`, `LAST` and `LEAVE` run at special moments.
my @found;
for 1..10 -> $n {
    next if $n %% 2;
    last if $n > 7;
    @found.push($n);
}
is-deeply @found, ___, 'next skips the even numbers, last stops after 7';
my @pairs;
OUTER: for 1..3 -> $i {
    for 1..3 -> $j {
        next OUTER if $j > $i;
        @pairs.push("$i$j");
    }
}
is-deeply @pairs, ___, 'next OUTER continues the outer loop';
my @log;
for 1..3 {
    FIRST @log.push('start');
    @log.push($_);
    LAST @log.push('end');
}
is-deeply @log, ___, 'FIRST runs before the first iteration, LAST after the last';
my $cleanup = '';
{
    LEAVE $cleanup = 'done';
}
is $cleanup, ___, 'LEAVE runs whenever a block is left';
