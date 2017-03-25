#!/usr/bin/perl

use warnings;

my @words = qw{ fred barney pebbles dino wilma betty };
my $errors = 0;

for(@words) {
	print "Type the word $_: ";
	chomp(my $try = <STDIN>);
	if ($try ne $_) {
		print "Sorry - That's not right.\n\n";
		$errors ++;
		redo;
	}
}
