#!/usr/bin/perl
## Copyright (C) 20xx by Yours Truly
@lines = `perldoc -u -f atan2`;
foreach (@lines) {
	s/\w<([^>]+)/\U$1/g;
	print;
}
