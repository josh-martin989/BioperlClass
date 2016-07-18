#!/usr/bin/perl

use strict;
use warnings;

transpose_2d_array();

sub transpose_2d_array
{
	my @table;

	for(my $i = 1; $i <= 3; $i++)
	{
		my @row;
		for(my $j = 1; $j <= 3; $j++)
		{
			print "Enter row $i column $j:\n";
			my $in = <STDIN>;
			chomp $in;
			push(@row, $in);
		}
		push(@table, [@row]);
	}

	print "\n";
	for(my $i = 0; $i < 3; $i++)
	{
		for(my $j = 0; $j < 3; $j++)
		{
			print "$table[$j][$i]\t";
		}
		print "\n";
	}
}
