#!/usr/bin/perl

use strict;
use warnings;

my $result = gen_random(60);
print "$result\n";

$result = gen_random(60, "true");
print "$result\n";

sub gen_random
{
	my (@arguments) = (@_);
	my $length;
	if(!defined($arguments[1]))
	{
		$length = $arguments[0];
	}
	else
	{
		$length = int(rand $arguments[0]) + 1;
	}

	my $seq = "";

	for(my $i = 0; $i < $length; $i++)
	{
        	my $bases = "ATCG";
        	my $random = int(rand 4);
        	$seq .= substr($bases, $random, 1);
	}

	return $seq;
}
