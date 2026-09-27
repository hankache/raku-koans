# title: Mixins
# intro: `but` creates a copy of a value with a role mixed in. `does` mixes a role into an existing object. Either way, only that object changes, not its class.
my $answer = 42 but role { method explain { 'the answer to everything' } };
is $answer.explain, ___, 'the mixed-in method';
is $answer + 1, ___, 'and it is still 42';
my $zero = 0 but True;
is so($zero), ___, 'but can even change what a value means as a boolean';
role Loud { method speak { self.word.uc } }
class Dog { method word { 'woof' } }
my $rex = Dog.new;
$rex does Loud;
is $rex.speak, ___, 'does adds a role to an existing object';
dies-ok ___, 'other dogs cannot speak: try it on a new one';
