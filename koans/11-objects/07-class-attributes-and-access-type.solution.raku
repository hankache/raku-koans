class Human {
    has $.name;
    has $.age is rw;
    my $.population = 0;
    submethod TWEAK { Human.population++ }
}
is Human.population, 0, 'no humans yet';
my $john = Human.new(name => 'John', age => 21);
my $jane = Human.new(name => 'Jane', age => 25);
is Human.population, 2, 'each new human was counted';
is $jane.population, 2, 'every object sees the same class attribute';
$john.age = 23;
is $john.age, 23, 'is rw allows assignment';
dies-ok { $john.name = 'Jack' }, 'name is read-only: try to assign to it';
