# title: Proto tokens
# intro: A `proto token` declares a family of alternatives, each marked `:sym`. Adding an alternative later, even in a subclass, is just another token.
grammar Calc {
    rule TOP { <term> + % <op> }
    proto token op {*}
    token op:sym<+> { <sym> }
    token op:sym<-> { <sym> }
    token term { \d+ }
}
my $m = Calc.parse('4 + 5 - 2');
is so($m), ___, 'four terms and two operators';
is ~$m<op>[1], ___, 'the second operator';
is so(Calc.parse('4 * 5')), ___, 'there is no * yet';
grammar BiggerCalc is Calc {
    token op:sym<*> { <sym> }
}
is so(BiggerCalc.parse('4 * 5')), ___, 'a subclass added one more alternative';
