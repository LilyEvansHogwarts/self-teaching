#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use warnings;

$pi = 3.141592654;
print "Enter the radius of the circle:\n";
$r = <STDIN>;
if ($r < 0) {
	print 0 . "\n";
} else {
	$circumference = 2 * $pi * $r;
	print $circumference . "\n";
}

