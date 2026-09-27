# title: Directories
# intro: `mkdir` creates a directory, `rmdir` removes an empty one, and `dir` lists what a directory contains.
mkdir '/tmp/newfolder';
is '/tmp/newfolder'.IO.d, ___, 'mkdir created a directory';
spurt '/tmp/newfolder/a.txt', 'a';
spurt '/tmp/newfolder/b.txt', 'b';
is-deeply dir('/tmp/newfolder').map(*.basename).sort.List, ___, 'dir lists the contents';
unlink '/tmp/newfolder/a.txt', '/tmp/newfolder/b.txt';
rmdir '/tmp/newfolder';
is '/tmp/newfolder'.IO.e, ___, 'rmdir removed it';
