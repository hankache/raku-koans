# title: Substitution and transliteration
# intro: `s/…/…/` replaces a match in a variable, `:g` replaces every match. `.subst` does the same but returns a new string. `tr/…/…/` swaps characters.
my $s = 'a-b-c';
$s ~~ s/'-'/+/;
is $s, ___, 's/// replaces the first match';
my $t = 'a-b-c';
$t ~~ s:g/'-'/+/;
is $t, ___, ':g replaces them all';
is 'hello'.subst('l', 'L'), ___, '.subst returns a new string';
is 'hello'.subst('l', 'L', :g), ___, 'with :g, all of them';
my $word = 'hello';
$word ~~ tr/el/ip/;
is $word, ___, 'tr: e becomes i, l becomes p';
is ('a1b2c3' ~~ m:g/\d/).elems, ___, 'm:g finds every match';
