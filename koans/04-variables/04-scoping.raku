# title: Scoping
# intro: `my` gives a variable lexical scope: it exists only inside the block, the `{ }`, where it was declared.
my $var = 'outer';
{
    my $var = 'inner';
    is $var, ___, 'inside the block, the inner variable hides the outer one';
}
is $var, ___, 'outside, the outer one is untouched';
eval-dies-ok ___, 'a variable does not exist outside its block: give code that uses one there';
