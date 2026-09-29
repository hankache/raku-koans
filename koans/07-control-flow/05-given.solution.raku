sub describe($var) {
    given $var {
        when 0..50 { 'less than or equal to 50' }
        when Int   { 'a big Int' }
        default    { 'huh?' }
    }
}
is describe(42), 'less than or equal to 50', 'the first matching when wins';
is describe(99), 'a big Int', 'when Int matches any integer';
is describe(99.5), 'huh?', 'default catches everything else: 99.5 is too big and not an Int';
is describe('x'), 'huh?', 'a string is not a number in 0..50';
my @said;
given 42 {
    when 0..50 { @said.push('small'); proceed }
    when Int   { @said.push('Int'); proceed }
    when 42    { @said.push(42) }
    default    { @said.push('huh?') }
}
is-deeply @said, ['small', 'Int', 42], 'proceed keeps matching';
