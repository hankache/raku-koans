class Rectangle {
    has $.width = 1;
    has $.height = 1;
    has $.area;
    submethod TWEAK { $!area = $!width * $!height }
}
is Rectangle.new.area, 1, 'defaults: a 1 by 1 square';
is Rectangle.new(width => 3, height => 4).area, 12, 'TWEAK computed the area';
class Account {
    has $.balance = 0;
    submethod TWEAK { die 'negative balance' if $!balance < 0 }
}
is Account.new(balance => 10).balance, 10, 'a valid account';
dies-ok { Account.new(balance => -5) }, 'TWEAK can refuse bad values: try a negative balance';
