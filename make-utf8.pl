#!/usr/bin/perl

my $cr = "\n";

open (TABLE, "<utf8.table");

my %enc;

while(<TABLE>) {
    chomp;
    my @fields = split /;/;
    if ($#fields < 3) { next; }
    my $code = hex($fields[0]);
    my $unicode_name = $fields[1];
    my $tex_type = $fields[2];
    my $tex_macro = $fields[3];

    if ($code == 0) { next; }

    if ($code >= 0 && $code <= 0x7f) {
	printf STDERR "Ignoring ASCII entry (0x%x/%s)\n", $code, $unicode_name;
    } elsif ($code >= 0x80 && $code <= 0x7FF) {
	my $c1 = 0xc0 | ($code>>6);
	my $c2 = 0x80 | ($code & 0x3f);
	printf STDERR "0x%x %x %x $tex_macro\n", $code, $c1, $c2;
	$enc{$c1}{$c2} = [($tex_type, $tex_macro)];
    } elsif ($code >= 0x800 && $code <= 0xFFFF) {
	my $c1 = 0xe0 | ($code >> 12);
	my $c2 = 0x80 | (($code >> 6) & 0x3f);
	my $c3 = 0x80 | ($code & 0x3f);
	printf STDERR "0x%x %x %x $tex_macro\n", $code, $c1, $c2, $c3;
	$enc3{$c1}{$c2}{$c3} = [($tex_type, $tex_macro)];
    } else {
	printf STDERR "Ignoring high Unicode entry (0x%x)\n", $code;
    }
}

my $i;

for ($i = 128; $i < 162; $i++) {
    printf STDOUT "\\catcode`\\%c=12 %% %x\n", $i, $i;
}

for (; $i < 256; $i++) {
    printf STDOUT "\\catcode`\\%c=13 %% %x\n", $i, $i;
}

foreach my $c1 (keys %enc) {
    foreach my $c2 (keys %enc) {
	my $a = $enc2{$c2};
	print "$c1 -> $c2 -> ($a)\n";
    }
}
