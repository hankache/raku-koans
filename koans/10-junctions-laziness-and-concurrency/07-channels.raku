# title: Channels
# intro: A `Channel` is a queue that tasks can safely share: `send` puts a value in, `receive` takes one out, `close` says no more are coming.
my $c = Channel.new;
$c.send($_) for 1..3;
$c.close;
is-deeply $c.list.List, ___, 'list reads everything until the channel is closed';
my $inbox = Channel.new;
$inbox.send('hello');
is $inbox.receive, ___, 'receive takes one value';
is-deeply $inbox.poll, ___, 'poll returns Nil when the channel is empty';
my $work = Channel.new;
$work.send($_) for 1..4;
$work.close;
my $sum = start { my $total = 0; $total += $_ for $work.list; $total };
is await($sum), ___, 'a background task consumes the channel';
