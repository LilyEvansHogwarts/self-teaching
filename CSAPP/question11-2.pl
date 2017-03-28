#!/usr/bin/perl

use Time::Piece;
#use DateTime;

my $t = localtime;

my $now = DateTime->new(
		year => $t->year,
		month => $t->mon,
		day => $t->mday,
		);
my $then = DateTime->new(
		year => $ARGV[0],
		month => $ARGV[1],
		day => $ARGV[2],
		);

if ($now < $then) {
	die "You entered a date in the future.\n";
} else {
	my $duration = $now - $then;
	my @units = $duration->in_units( qw(year month day) );
	printf "%d years, %d months, and %d days\n", @units;
}
