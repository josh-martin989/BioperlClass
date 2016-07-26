package q3oldschoolRE;

use strict;
use warnings;

#Attributes
{
	my %_attrib_props = (
		_name => [ '' , 'read.write' ],
		_manufacturer => [ '' , 'read.write' ],
		_recogseq => ['' , 'read.write.required' , '^[ACGT]+\|[ACGT]+$'],
	);

	sub _all_attributes { return keys %_attrib_props }

	sub _permissions
	{
		my ($self, $attrib, $perms) = (@_);
		return $_attrib_props{$attrib}[1] =~ /$perms/;
	}

	sub _default_value
	{
		my ($self, $attrib) = (@_);
		return $_attrib_props{$attrib}[0];
	}

	sub _check_recog
	{
		my ($self, $attrib) = (@_);
		return $attrib =~ /$_attrib_props{_recogseq}[2]/;
	}
}

#Constructor
sub new
{
	my ($class, %args) = (@_);
	my $self = bless {} , $class;

	foreach my $attrib ($self->_all_attributes())
	{
		my ($arg) = $attrib =~ /^_(.*)/;
		if(exists $args{$arg})
		{
			$self->{$attrib} = $args{$arg};
		}
		elsif($self->_permissions($attrib, 'required'))
		{
			die("Missing required attribute $arg");
		}
		else
		{
			$self->{$attrib} = $self->_default_value($attrib);
		}
	}

	if(!($self->_check_recog($args{recogseq})))
	{
		die("_recogseq does not specify cut site, and/or it contains non-nucleotide characters.");
	}

	return $self;
}

#GET/SET
sub get_name
{
	my($self) = (@_);
	return $self->{_name};
}

sub get_manufacturer
{
	my($self) = (@_);
        return $self->{_manufacturer};
}

sub get_recogseq
{
	my($self) = (@_);
        return $self->{_recogseq};
}

sub set_name
{
	my($self, $new_name) = (@_);
	$self->{_name} = $new_name;
	return $self->{_name};
}

sub set_manufacturer
{
	my($self, $new_man) = (@_);
        $self->{_manufacturer} = $new_man;
        return $self->{_manufacturer};
}

sub set_recogseq
{
	my($self, $new_recogseq) = (@_);
	if($self->_check_recog($new_recogseq))
	{
        	$self->{_recogseq} = $new_recogseq;
		return $self->{_recogseq};
	}
        else
	{
		print "set_recog() failed, invalid recognition sequence.\n";
		return "";
	}
}

sub cut_dna
{
	my ($self, $sequence) = @_;
	my @ret_array;
	my @split = split('\|', $self->get_recogseq());
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
