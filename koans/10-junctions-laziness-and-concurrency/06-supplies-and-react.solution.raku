my @seen;
Supply.from-list(1..3).tap({ @seen.push($_) });
is-deeply @seen, [1, 2, 3], 'tap sees every value';
my @shouted;
react {
    whenever Supply.from-list(<a b c>) { @shouted.push(.uc) }
}
is-deeply @shouted, ['A', 'B', 'C'], 'react runs whenever blocks until the supply is done';
my $numbers = supply { emit 1; emit 2; done };
is-deeply $numbers.list.List, (1, 2), 'supply builds one with emit';
is-deeply Supply.from-list(1..6).grep(* %% 2).map(* * 10).list.List, (20, 40, 60), 'map and grep on a stream';
my $supplier = Supplier.new;
my @got;
$supplier.Supply.tap({ @got.push($_) });
$supplier.emit(7);
is-deeply @got, [7], 'a Supplier emits to whoever is tapping';
