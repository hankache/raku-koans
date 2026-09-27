my $answer = 42 but role { method explain { 'the answer to everything' } };
is $answer.explain, 'the answer to everything', 'the mixed-in method';
is $answer + 1, 43, 'and it is still 42';
my $zero = 0 but True;
is so($zero), True, 'but can even change what a value means as a boolean';
role Loud { method speak { self.word.uc } }
class Dog { method word { 'woof' } }
my $rex = Dog.new;
$rex does Loud;
is $rex.speak, 'WOOF', 'does adds a role to an existing object';
dies-ok { Dog.new.speak }, 'other dogs cannot speak: try it on a new one';
