#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use 5.010;
use strict;
use warnings;

while(<STDIN>) {
	if (/(F|f)red/a) {
		print $_;
	}
}
