#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

while(<STDIN>) {
	if (/[A-Z][a-z]+/a) {
		print $_;
	}
}
