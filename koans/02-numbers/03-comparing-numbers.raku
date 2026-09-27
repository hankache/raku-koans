# title: Comparing numbers
# intro: Numeric comparisons return `True` or `False`, except `<=>`, which answers `Less`, `Same` or `More`.
is 9 == 7, ___, '== numeric equality';
is 9 != 7, ___, '!= numeric inequality';
is 9 < 7,  ___, '< less than';
is 7 <= 7, ___, '<= less than or equal';
is 9 >= 7, ___, '>= greater than or equal';
is 1 <=> 1.0, ___, '<=> compares three ways: 1 and 1.0 are the same number';
is 1 <=> 2, ___, 'one is less than two';
is 3 <=> 2, ___, 'three is more than two';
