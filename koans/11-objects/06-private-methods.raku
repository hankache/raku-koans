# title: Private methods
# intro: A method named with `!` is private: it can only be called from inside the class, as `self!name`.
class Vault {
    has $.code = 1234;
    method !check($guess) { $guess == $!code }
    method open($guess) {
        self!check($guess) ?? 'open' !! 'locked';
    }
}
my $vault = Vault.new;
is $vault.open(1111), ___, 'the public method calls the private one';
is $vault.open(1234), ___, 'the right code';
throws-like { $vault.check(1234) }, ___, 'from outside, a private method does not exist';
