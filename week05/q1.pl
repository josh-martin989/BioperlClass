#!/usr/bin/perl

use strict;
use warnings;

my @a1 = (1, 2, 3, 4);
my @a2 = (2, 4, 6, 8);

my $ref1 = \@a1;
my $ref2 = \@a2;

my $mult_ref = multiply_arrays($ref1, $ref2);
foreach my $line (@{$mult_ref})
{
	foreach my $item (@{$line})
	{
		print "$item\t";
	}
	print "\n";
}


sub multiply_arrays
{
	my ($array1, $array2) = @_;
	my @matrix;
	my @row;
	for(my $i = 0; $i < scalar(@{$array1}); $i++)
	{
		push(@matrix, [@row]);
		for(my $j = 0; $j < scalar(@{$array2}); $j++)
		{
			$matrix[$i][$j] = $array1->[$i] * $array2->[$j];
		}
	}
	
	my $return_ref = \@matrix;
	return $return_ref;
}
