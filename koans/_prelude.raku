# Prepended to every koan. The build strips these comment lines and joins the
# rest onto ONE line, so error line numbers shift by exactly one.
# Never use a trailing # comment on a code line: the join would comment out the rest.

use Test;

# ___ is a unique sentinel. Any assertion given it as an argument fails, whatever
# the assertion (a plain value can't do that: `ok` and `nok` need opposite truths).
my class Blank { method Str { "___" }; method gist { "___" } };
sub term:<___> { Blank };

# Runs an assertion. Test reports failures at the caller's line, which would be the
# wrapper on line 1, so also report the learner's line (the parser keeps the last one).
sub koan-check(&test, |c) {
    my $at = "at web line " ~ callframe(2).line;
    if (|c.list, |c.hash.values).grep({ $_ =:= Blank }) {
        my $d = c.list.elems > 1 && c.list.tail ~~ Str ?? c.list.tail !! "";
        flunk $d; diag $at; return False
    };
    my $ok = test(|c);
    diag $at unless $ok;
    $ok
};

my &T-ok = &ok; my &T-nok = &nok; my &T-is = &is; my &T-isnt = &isnt;
my &T-is-deeply = &is-deeply; my &T-is-approx = &is-approx; my &T-cmp-ok = &cmp-ok;
my &T-like = &like; my &T-unlike = &unlike; my &T-isa-ok = &isa-ok; my &T-does-ok = &does-ok;
my &T-can-ok = &can-ok; my &T-dies-ok = &dies-ok; my &T-lives-ok = &lives-ok;
my &T-eval-dies-ok = &eval-dies-ok; my &T-eval-lives-ok = &eval-lives-ok;
my &T-throws-like = &throws-like;

# The koan runs inside this block (the epilogue closes it), where these shadow Test's.
{
sub ok(|c) { koan-check(&T-ok, |c) }; sub nok(|c) { koan-check(&T-nok, |c) };
sub is(|c) { koan-check(&T-is, |c) }; sub isnt(|c) { koan-check(&T-isnt, |c) };
sub is-deeply(|c) { koan-check(&T-is-deeply, |c) }; sub is-approx(|c) { koan-check(&T-is-approx, |c) };
sub cmp-ok(|c) { koan-check(&T-cmp-ok, |c) }; sub like(|c) { koan-check(&T-like, |c) };
sub unlike(|c) { koan-check(&T-unlike, |c) }; sub isa-ok(|c) { koan-check(&T-isa-ok, |c) };
sub does-ok(|c) { koan-check(&T-does-ok, |c) }; sub can-ok(|c) { koan-check(&T-can-ok, |c) };
sub dies-ok(|c) { koan-check(&T-dies-ok, |c) }; sub lives-ok(|c) { koan-check(&T-lives-ok, |c) };
sub eval-dies-ok(|c) { koan-check(&T-eval-dies-ok, |c) }; sub eval-lives-ok(|c) { koan-check(&T-eval-lives-ok, |c) };
sub throws-like(|c) { koan-check(&T-throws-like, |c) };
