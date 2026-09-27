my $var = 'outer';
{
    my $var = 'inner';
    is $var, 'inner', 'inside the block, the inner variable hides the outer one';
}
is $var, 'outer', 'outside, the outer one is untouched';
eval-dies-ok '{ my $secret = 1 }; $secret', 'a variable does not exist outside its block: give code that uses one there';
