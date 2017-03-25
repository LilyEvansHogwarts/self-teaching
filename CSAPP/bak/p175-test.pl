#!/usr/bin/perl

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
