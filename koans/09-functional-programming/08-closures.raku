# title: Closures
# intro: Every code object is a closure: it remembers the variables that were in scope where it was created.
sub generate-greeting {
    my $name = 'John Doe';
    sub greeting {
        "Good Morning $name";
    }
    return &greeting;
}
my $generated = generate-greeting;
is $generated(), ___, 'the inner sub still sees $name';
sub greeting-generator($period) {
    return sub ($name) {
        return "Good $period $name";
    }
}
my $morning = greeting-generator('Morning');
my $evening = greeting-generator('Evening');
is $morning('John'), ___, 'each closure keeps its own $period';
is $evening('Jane'), ___, 'same body, different environment';
