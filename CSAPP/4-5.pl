#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use warnings;
use strict;
use 5.010;

sub greet {
	state @former_name;
	my $name = shift;
	if ( @former_name == 0 ) {
		print "Hi " . $name . "! You are the first one here!\n";
	} else {
		print "Hi " . $name . "! I've seen: @former_name \n";
	}
	push @former_name, $name;
}

greet( "Fred" );
greet( "Barney" );
greet( "Wilma" );
greet( "Betty" );

