#!/usr/bin/perl

use strict;
use warnings;

use q3oldschoolRE;

my $re = q3oldschoolRE->new( recogseq => 'GAT|CGA');
my @cuts = $re->cut_dna("CGCGATCGAGGGCCC");
foreach(@cuts)
{
	print "$_\n";
}

my $t2 = q3oldschoolRE->new( recogseq => 'GATC|GA');
my @c2 = $t2->cut_dna("CGCGATCGAGGGCCC");
foreach(@c2)
{
        print "$_\n";
}

$t2->set_recogseq('GATCAGA');

print $t2->get_recogseq() . "\n";
