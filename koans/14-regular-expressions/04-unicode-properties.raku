# title: Unicode properties
# intro: `<:…>` matches characters by their Unicode property, in any script: `<:N>` numbers, `<:Lu>` uppercase letters, `<:Pd>` dashes.
is so('Devanagari Numbers १२३' ~~ / <:N> /), ___, 'contains a number, even a Devanagari one';
is so('Привет, Иван.' ~~ / <:Lu> /), ___, 'contains an uppercase letter';
is so('John-Doe' ~~ / <:Pd> /), ___, 'contains a dash';
is ~('Привет, Иван.' ~~ / <:Lu> /), ___, 'the first uppercase letter';
