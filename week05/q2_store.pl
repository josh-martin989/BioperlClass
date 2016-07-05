#!/usr/bin/perl

use strict;
use warnings;

use Storable;

my @sequences;
for(my $i = 0; $i < 10; $i++)
{
	my $dna = gen_random(50);
	push(@sequences, $dna);
}

store \@sequences , 'q2file';


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
