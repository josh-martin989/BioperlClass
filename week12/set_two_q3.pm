package set_two_q3;

use strict;
use warnings;
use Moose;
use Moose::Util::TypeConstraints;

subtype 'aaseq'
  => as 'Str'
  => where { $_ =~ /^[ARNDUCQEOGHILKMFPSTWYV]+$/ };

has p1 => (
  is => 'rw',
  isa => 'Int',
  default => 1,
  required => 1,
);

has p2 => (
  is => 'rw',
  isa => 'Int',
);

has seq => (
  is => 'rw',
  isa => 'aaseq'
);

sub gen_random
{
	my $self = shift;
	my $seq = "";
	my $AA = "ARNDUCQEOGHILKMFPSTWYV";
	my $p1 = $self->p1;
	my $p2 = $self->p2;

	if(defined($p2))
	{
		my $diff = $p2 - $p1;
		my $length = int(rand ($diff + 1)) + $p1;
		for(my $i = 0; $i < $length; $i++)
		{
			$seq .= substr($AA, int(rand 22), 1);
		}
	}
	else
	{
		for(my $i = 0; $i < $p1; $i++)
		{
			$seq .= substr($AA, int(rand 22), 1);
		}
	}
	
	$self->seq($seq);
	return $seq;
}


1;
