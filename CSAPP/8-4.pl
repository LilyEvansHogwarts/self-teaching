#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use strict;
use warnings;
use 5.010;

while(<>) {
	if(/(?<word>\b(\w+)a\b)/) {
		print "'word' contains '$1'\n";
	}
}