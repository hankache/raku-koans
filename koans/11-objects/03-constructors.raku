# title: Named and positional arguments
# intro: The default `new()` only accepts named arguments. Write your own `new()` and call `self.bless` to accept positional ones.
class Human {
    has $.name;
    has $.age;
    method new($name, $age) {
        self.bless(:$name, :$age);
    }
}
my $john = Human.new('John', 23);
is $john.name, ___, 'positional arguments, in order';
is $john.age, ___, 'bless sets the attributes by name';
dies-ok ___, 'our new() needs both arguments: try calling it with one';
