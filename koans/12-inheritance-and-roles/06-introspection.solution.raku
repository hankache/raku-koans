class Human {
    has Str $.name;
    has Int $.age;
    method introduce-yourself { 'Hi, I am ' ~ self.name }
}
class Employee is Human {
    has Str $.company;
}
my $jane = Employee.new(name => 'Jane', age => 25, company => 'Acme');
is-deeply $jane.WHAT, Employee, 'the class it was created from';
is-deeply Employee.^parents.map(*.^name).List, ('Human',), 'its parent classes';
is-deeply Human.^attributes.map(*.name).sort.List, ('$!age', '$!name'), 'the attributes (names start with $!)';
is Human.^methods.map(*.name).grep('introduce-yourself').elems, 1, 'its methods include introduce-yourself';
is so($jane ~~ Human), True, '~~ is true for the class and its ancestors';
