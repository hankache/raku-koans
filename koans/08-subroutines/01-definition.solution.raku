sub alien-greeting {
    'Hello earthlings';
}
is alien-greeting, 'Hello earthlings', 'call it by its name';
is alien-greeting(), 'Hello earthlings', 'or with empty parentheses';
is &alien-greeting.name, 'alien-greeting', 'the & sigil refers to the sub itself';
