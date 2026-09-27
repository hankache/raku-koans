mkdir '/tmp/newfolder';
is '/tmp/newfolder'.IO.d, True, 'mkdir created a directory';
spurt '/tmp/newfolder/a.txt', 'a';
spurt '/tmp/newfolder/b.txt', 'b';
is-deeply dir('/tmp/newfolder').map(*.basename).sort.List, ('a.txt', 'b.txt'), 'dir lists the contents';
unlink '/tmp/newfolder/a.txt', '/tmp/newfolder/b.txt';
rmdir '/tmp/newfolder';
is '/tmp/newfolder'.IO.e, False, 'rmdir removed it';
