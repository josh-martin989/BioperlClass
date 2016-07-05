#!/usr/bin/perl

use strict;
use warnings;

use Storable;

my $store_ref = retrieve( 'q2file' );

my $iter = 1;
foreach my $seq (@{$store_ref})
{
	if($seq =~ /([ATCG])\1\1\1/)
        {
                print "$1 run found in seq $iter\n";
        }
	$iter++;
}
