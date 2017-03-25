#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use 5.010;
use warnings;
use strict;

my %name = ( fred => 'flintstone', barney => 'rubble', wilma => 'flintstone' );
my $longest = 0;
foreach my $key (sort keys %name) {
	if (length($key) > $longest) {
		$longest = length($key);
	}
}

foreach my $key (sort keys %name) {
	printf "-%${longest}s %s\n", $key, $name{$key};
}
