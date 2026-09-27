# title: Using Unicode
# intro: A character can be written directly, by code point with `\x`, or by name with `\c[…]`. Some characters can be composed from several code points.
is "\x0061", ___, '\x and a code point';
is "\c[LATIN SMALL LETTER A]", ___, '\c and a code point name';
is "\c[WHITE SMILING FACE]", ___, 'a smiley';
is "\x0061\x0301", ___, 'a plus a combining acute accent is á';
is 'á'.uniname, ___, 'uniname gives the code point name';
is-deeply 'á'.NFD.list, ___, 'NFD decomposes it into its parts';
my $Δ = 1;
$Δ++;
is $Δ, ___, 'Unicode letters can be used in names';
is 2 + ⅒, ___, 'and Unicode numbers in math';
