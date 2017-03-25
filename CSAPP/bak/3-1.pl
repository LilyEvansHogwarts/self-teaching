#!/usr/bin/perl

use warnings;

@lines = <STDIN>;
@reverse_lines = reverse @lines;
foreach (@reverse_lines) {
	print $_;
}
