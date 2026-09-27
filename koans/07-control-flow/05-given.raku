# title: given
# intro: `given` is Raku's switch statement. Each `when` smartmatches the value; the first match wins, unless it says `proceed`.
sub describe($var) {
    given $var {
        when 0..50 { 'less than or equal to 50' }
        when Int   { 'a big Int' }
        default    { 'huh?' }
    }
}
is describe(42), ___, 'the first matching when wins';
is describe(99), ___, 'when Int matches any integer';
is describe(99.5), ___, 'default catches everything else: 99.5 is too big and not an Int';
my @said;
given 42 {
    when 0..50 { @said.push('small'); proceed }
    when Int   { @said.push('Int'); proceed }
    when 42    { @said.push(42) }
    default    { @said.push('huh?') }
}
is-deeply @said, ___, 'proceed keeps matching';
