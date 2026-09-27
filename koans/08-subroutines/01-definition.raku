# title: Definition
# intro: `sub` defines a subroutine. Call it by name; parentheses are optional when there are no arguments.
sub alien-greeting {
    'Hello earthlings';
}
is alien-greeting, ___, 'call it by its name';
is alien-greeting(), ___, 'or with empty parentheses';
is &alien-greeting.name, ___, 'the & sigil refers to the sub itself';
