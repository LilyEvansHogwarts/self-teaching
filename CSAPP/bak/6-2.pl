#!/use/bin/perl

use warnings;
use strict;
use 5.010;

my %name;
while(<STDIN>) {
	chomp;
	if (exists $name{$_}) {
		$name{$_} += 1;
	} else {
		$name{$_} = 1;
	}
}

foreach my $key (sort keys %name) {
	print "$key => $name{$key}\n";
}
