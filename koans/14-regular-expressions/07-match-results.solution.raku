if 'Rakudo is a Perl 6 compiler' ~~ m/:s Perl 6/ {
    is ~$/, 'Perl 6', '$/ holds the match';
    is $/.prematch, 'Rakudo is a ', 'prematch: the string before it';
    is $/.postmatch, ' compiler', 'postmatch: the string after it';
    is $/.from, 12, 'from: where it starts';
    is $/.to, 18, 'to: where it ends';
}
