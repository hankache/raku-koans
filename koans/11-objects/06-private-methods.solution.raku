class Vault {
    has $.code = 1234;
    method !check($guess) { $guess == $!code }
    method open($guess) {
        self!check($guess) ?? 'open' !! 'locked';
    }
}
my $vault = Vault.new;
is $vault.open(1111), 'locked', 'the public method calls the private one';
is $vault.open(1234), 'open', 'the right code';
throws-like { $vault.check(1234) }, X::Method::NotFound, 'from outside, a private method does not exist';
