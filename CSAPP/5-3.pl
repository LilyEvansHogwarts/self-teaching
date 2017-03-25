#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use strict;
use warnings;
use 5.010;
use autodie;

print "What column width would you like?\n";
chomp(my $width = <STDIN>);

print "Enter some lines, then press Ctrl-D:\n";
chomp(my @lines = <STDIN>);

print "1234567890" x 7, "12345\n";

foreach (@lines) {
#	printf "%${width}s\n",$_;
	printf "%*s\n", $width, $_;
}
