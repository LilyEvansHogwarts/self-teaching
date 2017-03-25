#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use warnings;
use strict;
use 5.010;

sub greet {
	state $former_name;
	my $name = shift;
	if ( defined $former_name ) {
		print "Hi " . $name . "! $former_name is also here!\n";
	} else {
		print "Hi " . $name . "! You are the first one here!\n";
	}
	$former_name = $name;
}

greet( "Fred" );
greet( "Barney" );
greet( "Wilma" );
greet( "Betty" );

