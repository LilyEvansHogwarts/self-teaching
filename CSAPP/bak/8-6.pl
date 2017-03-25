#!/usr/bin/perl

use strict;
use warnings;

while(<>) {
	chomp;
	if(/\s\z/) {
		print "$_#\n";
	}
}
