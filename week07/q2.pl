#!/usr/bin/perl

use strict;
use warnings;

my $function = \&ret_hash_ref;

my $p_hash = $function->();

print "key\tvalue\n";
foreach my $key (keys(%{$p_hash}))
{
	print "$key\t$p_hash->{$key}\n";
}

sub ret_hash_ref
{
	my %hash;
	$hash{one} = 1;
	$hash{two} = 2;
	$hash{three} = 3;
	my $ret_ref = \%hash;
	return $ret_ref;
}
