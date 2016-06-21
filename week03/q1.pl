#!/usr/bin/perl

use strict;
use warnings;

for(my $i = 1; $i <= 12; $i++)
{
	for(my $j = 1; $j <= 12; $j++)
	{
		my $mult = $i * $j;
		if($j == 12)
		{
			print "$mult\n";
		}
		else
		{
			print "$mult\t";
		}
	}
}
