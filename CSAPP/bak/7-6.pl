#!/usr/bin/perl

use 5.010;
use warnings;
use strict;

while(<STDIN>) {
	if(/(wilma|fred)/a) {
		print $_;
	}
}
