#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use warnings;
use strict;
use 5.010;
sub total {
	state $sum = 0;
	foreach (@_) {
		$sum += $_;
	}
	$sum;
}

print "The total of those numbers from 1 to 1000 is " . total(1..1000) . "\n";
