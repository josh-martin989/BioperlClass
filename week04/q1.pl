#!/usr/bin/perl

use strict;
use warnings;

my %hoa = (
		count => [1, 2, 3, 4, 5],
		prime => [2, 3, 5, 7, 11],
		fib => [1, 2, 3, 5, 8]
);


foreach my $key (keys(%hoa))
{
	print "$key\n";
	foreach my $num (@{$hoa{$key}})
	{
		print "\t$num";
	}
	print "\n";
}
