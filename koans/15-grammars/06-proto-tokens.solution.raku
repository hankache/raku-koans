grammar Calc {
    rule TOP { <term> + % <op> }
    proto token op {*}
    token op:sym<+> { <sym> }
    token op:sym<-> { <sym> }
    token term { \d+ }
}
my $m = Calc.parse('4 + 5 - 2');
is so($m), True, 'four terms and two operators';
is ~$m<op>[1], '-', 'the second operator';
is so(Calc.parse('4 * 5')), False, 'there is no * yet';
grammar BiggerCalc is Calc {
    token op:sym<*> { <sym> }
}
is so(BiggerCalc.parse('4 * 5')), True, 'a subclass added one more alternative';
