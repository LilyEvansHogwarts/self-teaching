#!/usr/bin/perl

use 5.010;
use warnings;
use strict;

foreach (<STDIN>) {
	if(/fred/a) {
		print $_;
	}
}

#while(<STDIN>) {
#	if(/fred/a) {
#		print $_;
#	}
#}
