#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

while(<STDIN>) {
	if (/(F|f)red/a) {
		print $_;
	}
}
