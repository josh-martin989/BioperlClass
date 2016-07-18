#!/usr/bin/perl

use strict;
use warnings;

print "Enter scale you are converting FROM ('F' for Fahrenheit or 'C' for Celsius or 'exit' to quit):\n";
my $scale = <STDIN>;
chomp $scale;

while(!($scale eq "F") && !($scale eq "C") && !($scale eq "exit"))
{
	print "Please enter 'F', 'C', or 'exit'\n";
	$scale = <STDIN>;
	chomp $scale;
}

my $result;
if($scale eq "F")
{
	$result = convert_temp("F");
	print "Converted temperature is $result degrees Celsius\n";
}
elsif($scale eq "C")
{
	$result = convert_temp("C");
	print "Converted temperature is $result degrees Fahrenheit\n";
}
else
{
	exit;
}


sub convert_temp
{
	my ($from) = @_;
	print "Enter temperature value:\n";
	my $val = <STDIN>;
	chomp $val;
	
	if($from eq "F")
	{
		return (($val - 32) * (5/9));
	}
	else
	{
		return (($val * (9/5)) + 32);
	}
}
