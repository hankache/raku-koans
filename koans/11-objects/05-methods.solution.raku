class Human {
    has $.name;
    has $.age;
    has $.eligible;
    method assess-eligibility {
        if self.age < 21 {
            $!eligible = 'No';
        } else {
            $!eligible = 'Yes';
        }
    }
}
my $john = Human.new(name => 'John', age => 23);
is-deeply $john.eligible, Any, 'not assessed yet';
$john.assess-eligibility;
is $john.eligible, 'Yes', 'the method changed the attribute';
my $jane = Human.new(name => 'Jane', age => 19);
$jane.assess-eligibility;
is $jane.eligible, 'No', 'too young';
