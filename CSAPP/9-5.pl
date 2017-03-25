#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use warnings;

my %do_these;
foreach (@ARGV) {
	$do_these{$_} = 1;
}

while(<>) {
	if(/\A## Copyright/) {
		delete $do_these{$ARGV};
	}
}

@ARGV = sort keys %do_these;

$^I = ".bak";
while(<>) {
	if(/^#!/) {
		$_ .= "## Copyright (C) 20xx by Yours Truly\n";
	}
	print;
}
