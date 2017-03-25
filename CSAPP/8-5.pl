#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use strict;
use warnings;
use 5.010;

while(<>) {
	if(/(\b(\w*)a\b)(.{5})/) {
		print "'$1' '$3'\n";
	}
}
