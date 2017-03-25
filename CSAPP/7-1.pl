#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

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
