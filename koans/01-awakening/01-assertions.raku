# title: Assertions
# intro: Every koan is a set of assertions from Raku's `Test` module. Replace each `___` so they all pass. `ok` wants something true, `nok` something false; `is` compares two values, `isnt` wants them to differ.
ok ___, 'ok passes when given something true';
nok ___, 'nok passes when given something false';
is 1 + 1, ___, 'is compares what you got with what you expected';
is 'Raku', ___, 'is compares strings too';
isnt 'cat', ___, 'isnt wants the two sides to differ';
