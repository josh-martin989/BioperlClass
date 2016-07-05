#!/usr/bin/perl

use strict;
use warnings;

use CGI(':standard');

my $title = 'Week 5 Third Question';
print header,
     start_html($title),
     h1($title);

if(param('submit'))
{
	my $seqtype = param('seqtype');
	my $print_seq;
	if($seqtype eq "Nucleotide")
	{
		$print_seq = gen_random_DNA(50);
	}
	elsif($seqtype eq "Amino Acid")
	{
		$print_seq = gen_random_AA(50);
	}
	else
	{
		print p("Please select a sequence type.");
	}
	
	print p("Your $seqtype sequence is: $print_seq");
}

my $url = url();
print start_form(-method => 'GET', action => $url),
     p("Choose whether to generate a nucleatide or amino acid sequence: " . radio_group(-name => 'seqtype',
     -values => ['Nucleotide', 'Amino Acid'])),
     p(submit(-name => 'submit', value => 'Submit')),
     end_form(),
     end_html();


sub gen_random_DNA
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

sub gen_random_AA
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
                my $bases = "ARNDBCQEZGHILKMFPSTWYV";
                my $random = int(rand 22);
                $seq .= substr($bases, $random, 1);
        }

        return $seq;
}
