# title: Testing objects
# intro: `Test` can check what an object is and what it can do: `isa-ok` checks its class and parents, `does-ok` a role, and `can-ok` a method.
isa-ok 42, ___, 'isa-ok checks the type of a value';
isa-ok 42, ___, 'types have parents: an Int is also Cool';
role Flies { }
class Butterfly does Flies { method flutter { 'flap flap' } }
isa-ok Butterfly.new, ___, 'an object is of its class';
does-ok Butterfly.new, ___, 'does-ok checks for a role';
can-ok Butterfly.new, ___, 'can-ok checks that a method exists';
can-ok 'text', ___, 'built-in types have methods too';
