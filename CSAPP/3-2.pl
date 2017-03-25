#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use warnings;

@names = qw/ fred betty barney dino wilma pebbles bamm-bamm /;
@lines = <STDIN>;
foreach (@lines) {
	print $names[$_ - 1] . "\n";
}
