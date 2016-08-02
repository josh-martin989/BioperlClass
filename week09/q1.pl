#!/usr/bin/perl

use strict;
use warnings;

use Bio::Perl;

if(!(scalar(@ARGV) == 1))
{
	print "Please pass the name of one FASTA file as the argument to this program.\n";
	exit;
}

my $file = $ARGV[0];
my @bio_seqs = read_all_sequences($file, 'fasta');

print "The following are the sequences read in from $file:\n";
my $iter = 1;
foreach my $seq (@bio_seqs)
{
	my $name = $seq->display_id;
	my $accession = $seq->accession_number;
	my $beginning = $seq->subseq(1, 20);

	print "\nSequence \#$iter\n$name\n$accession\n$beginning\n";
	$iter++;
}

my $seq_count = scalar(@bio_seqs);
my $ask_bool = "false";
while($ask_bool eq "false")
{
	print "Enter a comma-separated list of sequence numbers (1 - $seq_count) to BLAST:\n";
	my $list = <STDIN>;
	chomp $list;
	my @split = split(',', $list);
	my $valid_bool = "true";
	foreach my $list_test(@split)
	{
		if(($list_test < 1) || ($list_test > $seq_count) || ($list_test =~ /\D/))
		{
			$valid_bool = "false";
		}
	}
	if($valid_bool eq "true")
	{
		$ask_bool = "true";
		foreach my $blast_seq (@split)
		{
			my $final;
			if($bio_seqs[$blast_seq]->seq =~ /^[ACTG]+$/)
			{
				$final = translate($bio_seqs[$blast_seq]->seq);
			}
			elsif($bio_seqs[$blast_seq]->seq =~ /^[ARNDBCQEZGHILKMFPSTWYV]+$/)
			{
				$final = $bio_seqs[$blast_seq]->seq;
			}
			else
			{

			}
			my $blast = blast_sequence($final) or die "can't BLAST sequence $blast_seq\n";
			my $out_file = "BLAST_seq_$blast_seq\_output.txt";
			write_blast("> $out_file", $blast);
		}
	}
}
