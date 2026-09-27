sub vehicle($seats) {
    if $seats <= 5 {
        'sedan'
    } elsif $seats <= 7 {
        '7 seater'
    } else {
        'van'
    }
}
is vehicle(4), 'sedan', 'four seats';
is vehicle(7), '7 seater', 'seven seats';
is vehicle(9), 'van', 'nine seats';
my $age = 19;
my $message = 'Go home';
$message = 'Welcome' if $age > 18;
is $message, 'Welcome', 'a trailing if';
