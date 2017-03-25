#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly

use warnings;

my $in = $ARGV[0];

if(! defined $in) {
	die "no such file.\n";
}

my $out = $in;
#$out =~ s/(\.\w+)?$/.out/;
$out =~ s/$/.out/;

if(! open $in_fh, '<', $in) {
	die "Can't open '$in': $!\n";
}

if(! open $out_fh, '>', $out) {
	die "Can't open '$out': $!\n";
}

while(<$in_fh>) {
	chomp;
	s/Fred/\n/ig;
	s/wilma/Fred/ig;
	s/\n/Wilma/g;
	print $out_fh "$_\n";
}
