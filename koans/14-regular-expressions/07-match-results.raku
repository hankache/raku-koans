# title: Match results
# intro: A successful match is stored in `$/`. It knows what matched, what came before and after, and where it starts and ends. `:s` makes whitespace in the regex count.
if 'Rakudo is a Perl 6 compiler' ~~ m/:s Perl 6/ {
    is ~$/, ___, '$/ holds the match';
    is $/.prematch, ___, 'prematch: the string before it';
    is $/.postmatch, ___, 'postmatch: the string after it';
    is $/.from, ___, 'from: where it starts';
    is $/.to, ___, 'to: where it ends';
}
