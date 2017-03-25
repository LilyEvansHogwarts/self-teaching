#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

while(<>) {
	if(/(\b(\w*)a\b)(.{5})/) {
		print "'$1' '$3'\n";
	}
}
