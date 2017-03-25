#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use 5.010;
use warnings;
use strict;

while(<STDIN>) {
	if(/(wilma|fred)/a) {
		print $_;
	}
}
