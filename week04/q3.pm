package q3;

=head1 USAGE

 gen_random(LENGTH, OPTIONALFLAG)

 When called with one argument (LENGTH), this function returns a string of random DNA bases of length LENGTH.

 When given a LENGTH as well as the optional second argument OPTIONALFLAG, this function will return a string of random DNA bases of a random length between 1 and LENGTH inclusive. This function uses defined() to check for the second argument, so any value that makes defined() true can be passed to the function.

=head1 EXAMPLES

 gen_random(50)

 gen_random(50, "True")

=cut

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
