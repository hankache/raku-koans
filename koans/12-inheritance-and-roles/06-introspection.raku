# title: Introspection
# intro: `.WHAT` gives an object's class. The meta-object, reached with `.^`, knows its attributes, methods and parents.
class Human {
    has Str $.name;
    has Int $.age;
    method introduce-yourself { 'Hi, I am ' ~ self.name }
}
class Employee is Human {
    has Str $.company;
}
my $jane = Employee.new(name => 'Jane', age => 25, company => 'Acme');
is-deeply $jane.WHAT, ___, 'the class it was created from';
is-deeply Employee.^parents.map(*.^name).List, ___, 'its parent classes';
is-deeply Human.^attributes.map(*.name).sort.List, ___, 'the attributes (names start with $!)';
is Human.^methods.map(*.name).grep('introduce-yourself').elems, ___, 'its methods include introduce-yourself';
is so($jane ~~ Human), ___, '~~ is true for the class and its ancestors';
