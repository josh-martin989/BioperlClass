#!/usr/bin/perl

use strict;
use warnings;

$|++;

use Bio::DB::GenBank;
use Bio::SeqIO;
use Bio::Tools::Run::RemoteBlast;

my %programs;
$programs{blastp} = "protein";
$programs{blastn} = "dna";
$programs{blastx} = "dna";
$programs{tblastn} = "protein";
$programs{tblastx} = "dna";

my $btype = $ARGV[0];
my $stype = $ARGV[1];
my $accession = $ARGV[2];

if(!(exists($programs{lc($btype)})))
{
	print "Invalid program type.\n";
	exit;
}
else
{
	if($programs{lc($btype)} ne lc($stype))
	{
		print "Query sequence type does not match the program type.\n";
		exit;
	}
}

my $genbank_dbh = Bio::DB::GenBank->new();
my $seqio = $genbank_dbh->get_Stream_by_acc($accession);
my $sequence = $seqio->next_seq();

my $factory = Bio::Tools::Run::RemoteBlast->new( -prog => "$btype",
						 -data => 'nr',
						 -expect => '1e-3',
						 -readmethod => 'SearchIO');

print "Submitting BLAST\n";
$factory->submit_blast($sequence);

while(my @rids = $factory->each_rid)
{
	print ".";
	foreach my $rid (@rids)
	{
		my $result = $factory->retrieve_blast($rid);
		if(ref($result))
		{
			my $output = $result->next_result();
			my $filename = $accession . "__" . $btype . ".out";
			$factory->save_output($filename);
			$factory->remove_rid($rid);
		}
		elsif($result < 0)
		{
			$factory->remove_rid($rid);
		}
		else
		{
			sleep 5;
		}
	}
}
