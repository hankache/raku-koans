# title: Bases and infinity
# intro: Numbers can be written and shown in other bases. Underscores make long numbers readable, and `Inf` is bigger than any number.
is 255.base(16), ___, 'base shows a number in another base';
is 5.base(2), ___, 'binary';
is :16<ff>, ___, ':16<…> reads a number written in base 16';
is 0b1010, ___, '0b is a binary literal';
is 0x1F, ___, '0x is a hexadecimal literal';
is 1_000_000, ___, 'underscores are ignored';
is Inf > 10 ** 100, ___, 'Inf is bigger than any number';
is Inf + 1, ___, 'and adding to it changes nothing';
