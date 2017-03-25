#!/usr/bin/perl

use 5.010;
use warnings;
use strict;

my %name = ( fred => 'flintstone', barney => 'rubble', wilma => 'flintstone' );

print "enter a name:\n";
chomp(my $line = <STDIN>);
print "the last name of $line is $name{$line}.\n";
