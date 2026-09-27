class Human {
    has $.name;
    has $.age;
    method new($name, $age) {
        self.bless(:$name, :$age);
    }
}
my $john = Human.new('John', 23);
is $john.name, 'John', 'positional arguments, in order';
is $john.age, 23, 'bless sets the attributes by name';
dies-ok { Human.new('Jane') }, 'our new() needs both arguments: try calling it with one';
