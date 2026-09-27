# title: Joining and repeating
# intro: `~` joins strings (concatenation) and `x` repeats them. Both happily turn numbers into strings first.
is 'Hi ' ~ 'there', ___, '~ joins two strings';
is 9 ~ 7, ___, 'numbers become strings when joined';
is 'Hello ' x 3, ___, 'x repeats a string';
is 13 x 3, ___, 'and numbers too';
