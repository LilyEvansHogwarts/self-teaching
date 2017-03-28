#!/usr/bin/perl

use Module::CoreList;

my %modules = %{ $Module::CoreList::version{5.006} };

for (keys %modules) {
	print "$_\t$modules{$_}\n";
}
