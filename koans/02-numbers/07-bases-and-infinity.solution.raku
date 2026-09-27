is 255.base(16), 'FF', 'base shows a number in another base';
is 5.base(2), '101', 'binary';
is :16<ff>, 255, ':16<…> reads a number written in base 16';
is 0b1010, 10, '0b is a binary literal';
is 0x1F, 31, '0x is a hexadecimal literal';
is 1_000_000, 1000000, 'underscores are ignored';
is Inf > 10 ** 100, True, 'Inf is bigger than any number';
is Inf + 1, Inf, 'and adding to it changes nothing';
