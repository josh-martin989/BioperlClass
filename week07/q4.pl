#!/usr/bin/perl

use strict;
use warnings;

my @tests = ("42", "00042", "0", "0.123", "0.00", "10.505", "-27", "-6.72", "-0.0090", "6.02e23", "-1.0e100");

#only integer (non-zero, positive)
print "Non-zero positive integer regex tests:\n";
foreach(@tests)
{
	if($_ =~ /^[1-9][0-9]*$/)
	{
		print "$_\t\tMATCH\n";
	}
	else
	{
		print "$_\t\tFAIL\n";
	}
}

#only integer or decimal (non-zero, positive) -> alternation cases: (decimal < 1 | integer >= 1 | decimal > 1)
print "\nNon-zero positive integer or decimal regex tests:\n";
foreach(@tests)
{
	if($_ =~ /^(0\.[0-9]*[1-9]+[0-9]*|[1-9][0-9]*|[1-9][0-9]*\.[0-9]*[1-9]+[0-9]*)$/)
	{
		print "$_\t\tMATCH\n";
	}
	else
	{
		print "$_\t\tFAIL\n";
	}
}

#positive or negative integer or decimal
print "\n(Positive or negative)(integer or decimal) regex tests:\n";
foreach(@tests)
{
	if($_ =~ /^\-?(0\.[0-9]*[1-9]+[0-9]*|[1-9][0-9]*|[1-9][0-9]*\.[0-9]*[1-9]+[0-9]*)$/)
	{
		print "$_\t\tMATCH\n";
	}
	else
	{
		print "$_\t\tFAIL\n";
	}
}

#positive or negative scientific notation
print "\nPositive or negative scientific notation regex tests:\n";
foreach(@tests)
{
	if($_ =~ /^\-?[1-9]\.[0-9]+e[1-9][0-9]*$/)
	{
		print "$_\t\tMATCH\n";
	}
	else
	{
		print "$_\t\tFAIL\n";
	}
}
