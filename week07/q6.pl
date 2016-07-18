#!/usr/bin/perl

use strict;
use warnings;

my @test1 = (42, 27, 100, 512, 23, 22, 21, 63, 28);
my @test2 = (104432, 109248219, 14829408, 182094184, 5781397591, 71395827, 18732598127, 7218479);

my $t1_max = max_num(@test1);
my $t1_min = min_num(@test1);

my $t2_max = max_num(@test2);
my $t2_min = min_num(@test2);

foreach(@test1)
{
	print "$_\t";
}
print "\nThe max of these numbers is $t1_max\n";
print "The min of these numbers is $t1_min\n\n";

foreach(@test2)
{
	print "$_\t";
}
print "\nThe max of these numbers is $t2_max\n";
print "The min of these numbers is $t2_min\n\n";


sub max_num
{
	my (@list) = @_;
	my $max = $list[0];
	foreach(@list)
	{
		if($_ > $max)
		{
			$max = $_;
		}
	}
	return $max;
}

sub min_num
{
	my (@list) = @_;
	my $min = $list[0];
	foreach(@list)
	{
		if($_ < $min)
		{
			$min = $_;
		}
	}
	return $min;
}
