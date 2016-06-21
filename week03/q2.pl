#!/usr/bin/perl

use strict;
use warnings;

print mult_table( 5 );

sub mult_table
{
	my ($limit) = (@_);
	my $string = "";
	for(my $i = 1; $i <= $limit; $i++)
	{
        	for(my $j = 1; $j <= $limit; $j++)
        	{
                	my $mult = $i * $j;
                	if($j == $limit)
                	{
                        	$string .= "$mult\n";
                	}
                	else
                	{
                        	$string .= "$mult\t";
                	}
        	}
	}
	return $string;
}
