#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

my $str = "beforematchafter";

if($str =~ /match/) {
	print "It matched!\n$`\n$&\n$'\n";
}
