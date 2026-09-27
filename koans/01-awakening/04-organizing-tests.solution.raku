subtest 'arithmetic' => {
    plan 2;
    is 2 + 2, 4, 'addition';
    is 2 * 3, 6, 'multiplication';
};
subtest 'strings' => {
    is 'a' ~ 'b', 'ab', '~ joins strings';
    is 'ab'.chars, 2, 'chars counts characters';
};
todo 'we are still learning our tables';
is 7 * 8, 54, 'a failing test marked todo does not count against you';
skip 'the browser has no network', 1;
pass 'pass records a success without testing anything';
