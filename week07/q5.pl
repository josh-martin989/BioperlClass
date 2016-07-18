#!/usr/bin/perl

use strict;
use warnings;

my $test_oligo1 = "ATCGATCAAATCCCCGGG";
my $test_oligo2 = "CGTATACTGCGTCATTACGCGATCTAGCGG";

calc_AnnTemp_and_GC($test_oligo1);
calc_AnnTemp_and_GC($test_oligo2);

sub calc_AnnTemp_and_GC
{
	my ($oligo) = @_;
	print "$oligo\n";
	my $anntemp = 0;
	my $GCcount = 0;
	my $length = length($oligo);
	for(my $i = 0; $i < $length; $i++)
	{
		my $char = substr($oligo, $i, 1);
		if(($char eq "A") || ($char eq "T"))
		{
			$anntemp = $anntemp + 2;
		}
		else
		{
			$anntemp = $anntemp + 4;
			$GCcount++;
		}
	}
	print "The annealing temp of this oligo is $anntemp degrees C\n";
	my $gc = $GCcount / $length;
	print "The GC content is $GCcount / $length = $gc%\n\n";
}
