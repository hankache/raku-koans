class Human {
    has $.name;
    has $.age;
    has $.nationality;
}
my $john = Human.new(name => 'John', age => 23, nationality => 'American');
is $john.name, 'John', 'has $.name generates an accessor method';
is $john.age, 23, 'every attribute gets one';
isa-ok $john, Human, '$john is an instance of Human';
is-deeply Human.new(name => 'Jane').age, Any, 'an attribute that was not set is empty';
