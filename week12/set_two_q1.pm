package set_two_q1;

=pod

 The function random_protein can take one or two parameters, both of which must be positive integers if supplied.  In one parameter mode, the function will return a sequence of random amino acids of a fixed length equal to the given parameter.  In the two parameter mode, the function will return a sequence of random amino acids of a length randomized between the two parameters (inclusive).

 USAGE:
 random_protein(7)	#will return a random AA sequence of length 7
 random_protein(1, 50)	#will return a random AA sequence with a length anywhere from 1 to 50

=cut

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = ( "random_protein" );

sub random_protein
{
	my (@rgs) = (@_);
	my $seq = "";
	my $AA = "ARNDUCQEOGHILKMFPSTWYV";
	if(!defined($rgs[0]))
	{
		print "No fixed length or range specified\n";
		exit;
	}
	elsif(!defined($rgs[1]))
	{
		for(my $i = 0; $i < $rgs[0]; $i++)
		{
			$seq .= substr($AA, int(rand 22), 1);
		}
	}
	else
	{
		my $diff = $rgs[1] - $rgs[0];
		my $length = int(rand ($diff + 1)) + $rgs[0];
		for(my $j = 0; $j < $length; $j++)
		{
			$seq .= substr($AA, int(rand 22), 1);
		}
	}

	return $seq;
}


1;
