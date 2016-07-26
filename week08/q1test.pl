#!/usr/bin/perl

use strict;
use warnings;

use RestrictionEnzyme;

my $re = RestrictionEnzyme->new( recogseq => 'GAT|CGA');

my @cuts = $re->cut_dna("CCAGGGATCGATTGGTAGATCGACCAATCATAAAA");

print "\nTest multiple sites:\n";
foreach(@cuts)
{
	print "$_\n";
}

print "\nTest one site:\n";
my $one = RestrictionEnzyme->new( recogseq => 'GA|TCGA');
my @one_cut = $one->cut_dna("CCAGGGATCGATTGG");
foreach(@one_cut)
{
	print "$_\n";
}

print "\nTest no sites:\n";
my $none = RestrictionEnzyme->new( recogseq => 'GATC|GA');
my @no_cut = $none->cut_dna("ATTCTCTCTGGGGAAAAAA");
foreach(@no_cut)
{
	print "$_\n";
}

print "\n";
