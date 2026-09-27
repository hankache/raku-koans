# title: Files
# intro: `spurt` writes a file and `slurp` reads it back. Your browser gives Raku a small in-memory filesystem to play with.
my $newdata = "New scores:\nPaul 10\nPaulie 9\nPaulo 11";
spurt '/tmp/newdatafile.txt', $newdata;
my $data = slurp '/tmp/newdatafile.txt';
is $data.lines.elems, ___, 'slurp reads the whole file';
is $data.lines[1], ___, 'the second line';
is '/tmp/newdatafile.txt'.IO.e, ___, '.IO.e asks whether a path exists';
is '/tmp/newdatafile.txt'.IO.f, ___, '.IO.f whether it is a file';
is '/tmp/newdatafile.txt'.IO.d, ___, '.IO.d whether it is a directory';
