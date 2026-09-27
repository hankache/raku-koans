sub greeting { "Hello, $*NAME" }
{
    my $*NAME = 'Camelia';
    is greeting(), 'Hello, Camelia', 'the sub sees the $*NAME of its caller';
}
{
    my $*NAME = 'Larry';
    is greeting(), 'Hello, Larry', 'another caller, another value';
}
sub inner { $*DEPTH + 1 }
sub outer { my $*DEPTH = 1; inner() }
is outer(), 2, 'it is found however deep the call';
