#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use strict;
use warnings;
use 5.010;

my $str = "beforematchafter";

if($str =~ /match/) {
	print "It matched!\n$`\n$&\n$'\n";
}
