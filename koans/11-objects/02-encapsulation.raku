# title: Encapsulation
# intro: The `!` twigil declares a private attribute: no accessor, and the default `new()` will not set it unless you add `is built`. The `.` twigil generates an accessor.
class Human {
    has $!name;
    has $.age;
    method greet { "Hi, I am {$!name // 'nobody'}" }
}
my $john = Human.new(name => 'John', age => 23);
is $john.age, ___, '$.age has an accessor';
is so(Human.can('age')), ___, '$.age generates an age method';
is so(Human.can('name')), ___, '$!name does not';
is $john.greet, ___, 'the default new() only sets public attributes: $!name stayed empty';
throws-like { $john.name }, ___, '$!name has no accessor: asking for it throws';
class Citizen {
    has $!name is built;
    method greet { "Hi, I am $!name" }
}
is Citizen.new(name => 'Jane').greet, ___, 'is built lets new() set a private attribute';
