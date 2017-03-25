#!/usr/bin/perl

use warnings;
use strict;
use 5.010;

my $num = int(1 + rand 100);
while(<STDIN>) {
	chomp;
	last if /quit|exit|\A\s*\z/i;
	print "Too high\n" if $_ > $num;
	print "Too low\n" if $_ < $num;
	last if $_ == $num;
}
