#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use warnings;

@lines = <STDIN>;
@sorted = sort @lines;
foreach (@sorted) {
	print $_;
}
chomp @sorted;
print "@sorted\n";
