#!/usr/bin/perl

use warnings;


foreach my $in (@ARGV) {
	if(! open $in_fh, '<', $in) {
		die "Can't open '$in': $!\n";
	}

        my $out = $in;

	$out =~ s/.bak$//;

	if(! open $out_fh, '>', $out) {
		die "Can't open '$out': $!\n";
	}
	while (<$in_fh>) {
		print $out_fh $_;
	}
}
