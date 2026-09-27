# title: Classes
# intro: `class` defines a template for objects; `has` declares its attributes. The default `new()` constructor takes named arguments.
class Human {
    has $.name;
    has $.age;
    has $.nationality;
}
my $john = Human.new(name => 'John', age => 23, nationality => 'American');
is $john.name, ___, 'has $.name generates an accessor method';
is $john.age, ___, 'every attribute gets one';
isa-ok $john, ___, '$john is an instance of Human';
is-deeply Human.new(name => 'Jane').age, ___, 'an attribute that was not set is empty';
