role Greeter[$greeting] {
    method greet($name) { "$greeting, $name" }
}
class English does Greeter['Hello'] { }
class French does Greeter['Bonjour'] { }
is English.new.greet('Ann'), 'Hello, Ann', 'one role…';
is French.new.greet('Ann'), 'Bonjour, Ann', '…two different classes';
role Box[::T] {
    method holds { T.^name }
}
class IntBox does Box[Int] { }
class StrBox does Box[Str] { }
is IntBox.new.holds, 'Int', 'the role knows the type it was given…';
is StrBox.new.holds, 'Str', '…and each class gives its own';
