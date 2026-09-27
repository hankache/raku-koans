# title: Supplies and react
# intro: A `Supply` is a stream of values that you `tap`, or `react` to with `whenever`. `supply { emit … }` builds one, and supplies have `map` and `grep` like lists.
my @seen;
Supply.from-list(1..3).tap({ @seen.push($_) });
is-deeply @seen, ___, 'tap sees every value';
my @shouted;
react {
    whenever Supply.from-list(<a b c>) { @shouted.push(.uc) }
}
is-deeply @shouted, ___, 'react runs whenever blocks until the supply is done';
my $numbers = supply { emit 1; emit 2; done };
is-deeply $numbers.list.List, ___, 'supply builds one with emit';
is-deeply Supply.from-list(1..6).grep(* %% 2).map(* * 10).list.List, ___, 'map and grep on a stream';
my $supplier = Supplier.new;
my @got;
$supplier.Supply.tap({ @got.push($_) });
$supplier.emit(7);
is-deeply @got, ___, 'a Supplier emits to whoever is tapping';
