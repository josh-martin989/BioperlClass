package q2;

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = ( "gen_random" );

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



1;
