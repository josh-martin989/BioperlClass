#!/usr/bin/perl

use strict;
use warnings;

for(my $i = 1;$i <= 10; $i++)
{
	open(my $file, "seq$i") or die "could not read seq$i\n";

	my $seq = <$file>;
	chomp $seq;
	if($seq =~ /([ATCG])\1\1\1/)
	{
		print "$1 run found in ./seq$i\n";
	}

	close($file);
}
