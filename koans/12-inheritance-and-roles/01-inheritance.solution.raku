class Human {
    has $.name;
    has $.age;
    method introduce-yourself { 'Hi I am a human being, my name is ' ~ self.name }
    submethod origin { 'Human only' }
}
class Employee is Human {
    has $.company;
    has $.salary;
}
class Manager is Employee {
    method introduce-yourself { 'Hi I am a manager, my name is ' ~ self.name ~ ' and I work at ' ~ self.company }
}
my $jane = Employee.new(name => 'Jane', age => 25, company => 'Acme', salary => 4000);
is $jane.name, 'Jane', 'an Employee has a name: inherited from Human';
is $jane.introduce-yourself, 'Hi I am a human being, my name is Jane', 'and the method';
my $mary = Manager.new(name => 'Mary', company => 'Acme');
is $mary.introduce-yourself, 'Hi I am a manager, my name is Mary and I work at Acme', 'Manager overrides it';
is Human.new.origin, 'Human only', 'a submethod works on its own class…';
dies-ok { $jane.origin }, '…but children do not inherit it';
