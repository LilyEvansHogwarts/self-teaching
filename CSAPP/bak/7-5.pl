#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

while(<STDIN>) {
	if(/(.)\1/a) {
		print $_;
	}
}
