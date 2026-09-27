# title: Methods
# intro: `method` defines a subroutine that belongs to an object. Inside, `self` is the object and `$!attribute` reaches the attribute directly.
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
is-deeply $john.eligible, ___, 'not assessed yet';
$john.assess-eligibility;
is $john.eligible, ___, 'the method changed the attribute';
my $jane = Human.new(name => 'Jane', age => 19);
$jane.assess-eligibility;
is $jane.eligible, ___, 'too young';
