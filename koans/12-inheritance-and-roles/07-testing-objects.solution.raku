isa-ok 42, Int, 'isa-ok checks the type of a value';
isa-ok 42, Cool, 'types have parents: an Int is also Cool';
role Flies { }
class Butterfly does Flies { method flutter { 'flap flap' } }
isa-ok Butterfly.new, Butterfly, 'an object is of its class';
does-ok Butterfly.new, Flies, 'does-ok checks for a role';
can-ok Butterfly.new, 'flutter', 'can-ok checks that a method exists';
can-ok 'text', 'uc', 'built-in types have methods too';
