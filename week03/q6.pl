#!/usr/bin/perl

use strict;
use warnings;

print "Enter regexp: ";
my $regex = <STDIN>;
chomp $regex;
my $string = "";

while($string ne "exit")
{
	print "Enter string or 'exit' to exit: ";
	$string = <STDIN>;
	chomp $string;
	if($string ne "exit")
	{
		if($string =~ /$regex/)
		{
			print "Match!\n";
		}
		else
		{
			print "No Match!\n";
		}
	}
}

print "Bye bye!\n";
