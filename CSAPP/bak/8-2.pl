#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

while(<>) {
	if(/a\b/) {
		print "$` ($&) $'";
	}
}
