package RestrictionEnzyme;

=pod

 The RestrictionEnzyme class has attributes for name, manufacturer, and recognition sequence.  Attributes 'name' and 'manufacturer' must be of type Str, and are able to be get and set.  Attribute 'recogseq' is required, and is able to be get and set.  It must be of a custom type, 'DnaCutSite', which is a string of DNA base characters with a pipe character in between to indicate the actual site of cleavage.

 This class has the method 'cut_dna', which takes an input sequence and cuts it at any locations where it matches the 'recogseq'.  If no sites are found that match the pattern, the full sequence is returned as the first item in the array. Otherwise, the array contains all the DNA fragments resulting from digestion with this RestrictionEnzyme.

=cut

use strict;
use warnings;
use Moose;
use Moose::Util::TypeConstraints;

subtype 'DnaCutSite'
  => as 'Str'
  => where { $_ =~ /^[ACGT]+\|[ACGT]+$/i };

has name => (
  is => 'rw' ,
  isa => 'Str',
);

has manufacturer => (
  is => 'rw' ,
  isa => 'Str',
);

has recogseq => (
  is => 'rw' ,
  isa => 'DnaCutSite',
  required => 1,
);


sub cut_dna
{
	my ($self, $sequence) = @_;
	my @ret_array;
	my @split = split('\|', $self->recogseq);
	my @digest = split(/$split[0]$split[1]/, $sequence);
	if(scalar(@digest) == 1)
	{
		push(@ret_array, $digest[0]);
	}
	else
	{
		for(my $i = 0; $i < scalar(@digest); $i++)
		{
			if($i == 0)
			{
				push(@ret_array, "$digest[$i]$split[0]");
			}
			elsif($i == (scalar(@digest) - 1))
			{
				push(@ret_array, "$split[1]$digest[$i]");
			}
			else
			{
				push(@ret_array, "$split[1]$digest[$i]$split[0]");
			}
		}
	}
	return @ret_array;
}


1;
