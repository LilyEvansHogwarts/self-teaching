#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

while(<>) {
	if(/(\b(\w+)a\b)/) {
		print "\$1 contains '$1'\n";
	}
}
