#!/usr/bin/perl

use strict;
use warnings;

my $what = 'fred|barney';
$_ = "hasdis sdasaasfredbarneyfredfredfredbarney";

if(/(${what})(${what})(${what})/g) {
	print "$&\n";
}
