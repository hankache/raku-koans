# title: if
# intro: `if` runs a block only when its condition is `True`. `elsif` and `else` add more paths. A condition can also follow the code it guards.
sub vehicle($seats) {
    if $seats <= 5 {
        'sedan'
    } elsif $seats <= 7 {
        '7 seater'
    } else {
        'van'
    }
}
is vehicle(4), ___, 'four seats';
is vehicle(7), ___, 'seven seats';
is vehicle(9), ___, 'nine seats';
my $age = 19;
my $message = 'Go home';
$message = 'Welcome' if $age > 18;
is $message, ___, 'a trailing if';
