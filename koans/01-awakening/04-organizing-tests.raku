# title: Organizing tests
# intro: `subtest` groups assertions under one name; `plan` says how many tests it will make. `todo` marks a test that is allowed to fail, `skip` records tests that should not run, and `pass` records a success.
subtest 'arithmetic' => {
    plan 2;
    is 2 + 2, ___, 'addition';
    is 2 * 3, ___, 'multiplication';
};
subtest 'strings' => {
    is 'a' ~ 'b', ___, '~ joins strings';
    is 'ab'.chars, ___, 'chars counts characters';
};
todo 'we are still learning our tables';
is 7 * 8, 54, 'a failing test marked todo does not count against you';
skip 'the browser has no network', 1;
pass 'pass records a success without testing anything';
