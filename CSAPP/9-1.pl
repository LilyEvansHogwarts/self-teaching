#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use strict;
use warnings;

my $what = 'fred|barney';
$_ = "hasdis sdasaasfredbarneyfredfredfredbarney";

if(/(${what})(${what})(${what})/g) {
	print "$&\n";
}
