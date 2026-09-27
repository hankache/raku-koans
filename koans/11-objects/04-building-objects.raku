# title: Building objects
# intro: Attributes can have defaults. The submethod `TWEAK` runs after `new()` has set the attributes: use it to compute more of them, or to check them.
class Rectangle {
    has $.width = 1;
    has $.height = 1;
    has $.area;
    submethod TWEAK { $!area = $!width * $!height }
}
is Rectangle.new.area, ___, 'defaults: a 1 by 1 square';
is Rectangle.new(width => 3, height => 4).area, ___, 'TWEAK computed the area';
class Account {
    has $.balance = 0;
    submethod TWEAK { die 'negative balance' if $!balance < 0 }
}
is Account.new(balance => 10).balance, ___, 'a valid account';
dies-ok ___, 'TWEAK can refuse bad values: try a negative balance';
