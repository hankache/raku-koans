# title: Parametric roles
# intro: A role can take parameters in square brackets, like a template. A parameter can even be a type, written `::T`.
role Greeter[$greeting] {
    method greet($name) { "$greeting, $name" }
}
class English does Greeter['Hello'] { }
class French does Greeter['Bonjour'] { }
is English.new.greet('Ann'), ___, 'one role…';
is French.new.greet('Ann'), ___, '…two different classes';
role Box[::T] {
    has T $.content;
    method holds { T.^name }
}
class IntBox does Box[Int] { }
class StrBox does Box[Str] { }
is IntBox.new.holds, ___, 'the role knows the type it was given…';
is StrBox.new.holds, ___, '…and each class gives its own';
dies-ok ___, 'the type parameter is enforced: try a string';
