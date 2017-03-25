#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use strict;
use warnings;

#chomp(my $date = `date`);
chomp(my $date = localtime);

$^I = ".bak";

while(<>) {
	s/^Author:.*/Author: Randal L. Schwartz/;
	s/^Phone:.*\n//;
	s/^Data:.*/Data: $date/;
	print;
}
