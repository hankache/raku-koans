my $newdata = "New scores:\nPaul 10\nPaulie 9\nPaulo 11";
spurt '/tmp/newdatafile.txt', $newdata;
my $data = slurp '/tmp/newdatafile.txt';
is $data.lines.elems, 4, 'slurp reads the whole file';
is $data.lines[1], 'Paul 10', 'the second line';
is '/tmp/newdatafile.txt'.IO.e, True, '.IO.e asks whether a path exists';
is '/tmp/newdatafile.txt'.IO.f, True, '.IO.f whether it is a file';
is '/tmp/newdatafile.txt'.IO.d, False, '.IO.d whether it is a directory';
