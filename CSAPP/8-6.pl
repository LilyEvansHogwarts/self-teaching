#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use strict;
use warnings;

while(<>) {
	chomp;
	if(/\s\z/) {
		print "$_#\n";
	}
}
