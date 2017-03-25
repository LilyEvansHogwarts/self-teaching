#!/usr/bin/perl

use warnings;
use strict;
use 5.010;
#注意区分state和my
sub total {
	my $sum = 0;
	foreach (@_) {
		$sum += $_;
	}
	$sum;
}

sub average {
	if (@_ == 0) { return }
	my $count = @_;
	my $sum = total(@_);
	$sum/$count;
}

sub above_average {
	my $average_number = average(@_);
	my @numbers;
	foreach my $number (@_) {
		if ($number > $average_number) {
			push @numbers, $number;
		}
	}
	@numbers;
}

my @fred = above_average(1..10);
print "\@fred is @fred\n";
print "(Should be 6 7 8 9 10)\n";
my @barney = above_average(100,1..10);
print "\@barney is @barney\n";
print "(Should be just 100)\n";
