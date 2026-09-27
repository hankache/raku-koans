# title: Dynamic variables
# intro: A variable with the `*` twigil, like `$*NAME`, is dynamic: a sub looks it up in the scope of whoever called it, not where the sub was written. Raku's own `$*OUT` works this way.
sub greeting { "Hello, $*NAME" }
{
    my $*NAME = 'Camelia';
    is greeting(), ___, 'the sub sees the $*NAME of its caller';
}
{
    my $*NAME = 'Larry';
    is greeting(), ___, 'another caller, another value';
}
sub inner { $*DEPTH + 1 }
sub outer { my $*DEPTH = 1; inner() }
is outer(), ___, 'it is found however deep the call';
