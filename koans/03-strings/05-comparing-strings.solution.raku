is 'John' eq 'John', True, 'eq string equality';
is 'John' ne 'Jane', True, 'ne string inequality';
is 'a' lt 'b', True, 'lt less than';
is 'a' gt 'b', False, 'gt greater than';
is 'a' le 'a', True, 'le less than or equal';
is 'a' leg 'b', Less, 'leg compares strings three ways';
is 'c' leg 'b', More, 'c comes after b';
is 3.5 cmp 2.6, More, 'cmp compares numbers as numbers';
