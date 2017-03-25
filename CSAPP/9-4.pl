#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

$^I = ".bak";

while(<>) {
	if(/^#!/) {
		$_ .= "## Copyright (C) 20xx by Yours Truly\n";
	}
	print;
}
