#!/usr/bin/perl

use warnings;

@lines = <STDIN>;
@sorted = sort @lines;
foreach (@sorted) {
	print $_;
}
chomp @sorted;
print "@sorted\n";
