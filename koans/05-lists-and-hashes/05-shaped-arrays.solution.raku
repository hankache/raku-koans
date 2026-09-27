my @array[3];
is @array.elems, 3, 'a fixed-size array has room for exactly its size';
my @tbl[3;2];
@tbl[0;0] = 1; @tbl[0;1] = 'x';
@tbl[1;0] = 2; @tbl[1;1] = 'y';
@tbl[2;0] = 3; @tbl[2;1] = 'z';
is-deeply @tbl.shape, (3, 2), 'shape describes the dimensions: a 3x2 grid';
is @tbl[1;1], 'y', 'index each dimension, separated by ;';
is @tbl[2;0], 3, 'third row, first column';
