# title: Returning values
# intro: A sub returns the value of its last statement, or whatever you `return` explicitly. `-->` in the signature restricts what may come back.
sub squared($x) {
    $x ** 2;
}
is squared(7), ___, 'the last expression is the return value';
sub cubed($x) {
    return $x ** 3;
    'never reached';
}
is cubed(2), ___, 'return leaves the sub at once';
sub squared-int($x --> Int) {
    return $x ** 2;
}
is squared-int(3), ___, 'an Int comes back fine';
throws-like { squared-int(1.2) }, ___, '1.2 squared is 1.44, a Rat: the return type check fails';
