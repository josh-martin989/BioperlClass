#!/usr/bin/perl

use strict;
use warnings;

my $length = 30;

my $seq = "";

for(my $i = 0; $i < 30; $i++)
{
	my $bases = "ATCG";
	my $random = int(rand 4);
	$seq .= substr($bases, $random, 1);
}

print "$seq\n";
