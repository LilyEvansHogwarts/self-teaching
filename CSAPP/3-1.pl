#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use warnings;

@lines = <STDIN>;
@reverse_lines = reverse @lines;
foreach (@reverse_lines) {
	print $_;
}
