sub squared($x) {
    $x ** 2;
}
is squared(7), 49, 'the last expression is the return value';
sub cubed($x) {
    return $x ** 3;
    'never reached';
}
is cubed(2), 8, 'return leaves the sub at once';
sub squared-int($x --> Int) {
    return $x ** 2;
}
is squared-int(3), 9, 'an Int comes back fine';
throws-like { squared-int(1.2) }, X::TypeCheck::Return, '1.2 squared is 1.44, a Rat: the return type check fails';
