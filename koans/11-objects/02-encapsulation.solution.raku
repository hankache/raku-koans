class Human {
    has $!name;
    has $.age;
    method greet { "Hi, I am {$!name // 'nobody'}" }
}
my $john = Human.new(name => 'John', age => 23);
is $john.age, 23, '$.age has an accessor';
is so(Human.can('age')), True, '$.age generates an age method';
is so(Human.can('name')), False, '$!name does not';
is $john.greet, 'Hi, I am nobody', 'the default new() only sets public attributes: $!name stayed empty';
throws-like { $john.name }, X::Method::NotFound, '$!name has no accessor: asking for it throws';
class Citizen {
    has $!name is built;
    method greet { "Hi, I am $!name" }
}
is Citizen.new(name => 'Jane').greet, 'Hi, I am Jane', 'is built lets new() set a private attribute';
