is so('Devanagari Numbers १२३' ~~ / <:N> /), True, 'contains a number, even a Devanagari one';
is so('Привет, Иван.' ~~ / <:Lu> /), True, 'contains an uppercase letter';
is so('John-Doe' ~~ / <:Pd> /), True, 'contains a dash';
is ~('Привет, Иван.' ~~ / <:Lu> /), 'П', 'the first uppercase letter';
