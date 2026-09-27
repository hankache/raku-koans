sub generate-greeting {
    my $name = 'John Doe';
    sub greeting {
        "Good Morning $name";
    }
    return &greeting;
}
my $generated = generate-greeting;
is $generated(), 'Good Morning John Doe', 'the inner sub still sees $name';
sub greeting-generator($period) {
    return sub ($name) {
        return "Good $period $name";
    }
}
my $morning = greeting-generator('Morning');
my $evening = greeting-generator('Evening');
is $morning('John'), 'Good Morning John', 'each closure keeps its own $period';
is $evening('Jane'), 'Good Evening Jane', 'same body, different environment';
