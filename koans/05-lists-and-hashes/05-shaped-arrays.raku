# title: Fixed-size and multidimensional arrays
# intro: Give an array a size in square brackets to fix its shape. Separate dimensions with a semicolon.
my @array[3];
is @array.elems, ___, 'a fixed-size array has room for exactly its size';
dies-ok ___, 'a fixed-size array refuses a fourth element';
my @tbl[3;2];
@tbl[0;0] = 1; @tbl[0;1] = 'x';
@tbl[1;0] = 2; @tbl[1;1] = 'y';
@tbl[2;0] = 3; @tbl[2;1] = 'z';
is-deeply @tbl.shape, ___, 'shape describes the dimensions: a 3x2 grid';
is @tbl[1;1], ___, 'index each dimension, separated by ;';
is @tbl[2;0], ___, 'third row, first column';
