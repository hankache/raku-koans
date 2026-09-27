# title: Class attributes and access type
# intro: `my` declares an attribute of the class itself, shared by all its objects. Attributes are read-only by default; `is rw` lets their accessor assign.
class Human {
    has $.name;
    has $.age is rw;
    my $.population = 0;
    submethod TWEAK { Human.population++ }
}
is Human.population, ___, 'no humans yet';
my $john = Human.new(name => 'John', age => 21);
my $jane = Human.new(name => 'Jane', age => 25);
is Human.population, ___, 'each new human was counted';
is $jane.population, ___, 'every object sees the same class attribute';
$john.age = 23;
is $john.age, ___, 'is rw allows assignment';
dies-ok ___, 'name is read-only: try to assign to it';
