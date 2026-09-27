# title: Lazy lists
# intro: `...` builds a lazy list from initial elements, a generator and an endpoint. Nothing is computed until you ask for it, so a list may even be infinite.
is-deeply (1 ... 10).List, ___, 'the default generator adds one';
is-deeply (1 ... Inf)[^5], ___, 'an infinite list: take only what you need';
is-deeply (0, 2 ... 10).List, ___, 'the generator (+2) is deduced';
is-deeply (0, { $_ + 3 } ... 12).List, ___, 'an explicit generator';
is-deeply (0, { $_ + 3 } ...^ * > 10).List, ___, '...^ * > 10: stop before the first value above ten';
