#!/usr/bin/perl

$^I = ".bak";

while(<>) {
	if(/^#!/) {
		$_ .= "## Copyright (C) 20xx by Yours Truly\n";
	}
	print;
}
