#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use warnings;
#use strict;
#use 5.010;

foreach (<STDIN>) {
	print "I saw $_";
}

while (<STDIN>) {
	print "I saw $_";
}
