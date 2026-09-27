# title: Truth
# intro: Every value in Raku can be asked whether it is `True`. Some answers may surprise you.
is so 0,       ___, 'zero is…';
is so '',      ___, 'an empty string is…';
is so '0',     ___, 'the string "0" (careful, Perl folks!) is…';
is so (),      ___, 'an empty list is…';
is so 'False', ___, 'a non-empty string is…';
is ?Any,       ___, 'a type object is…';
