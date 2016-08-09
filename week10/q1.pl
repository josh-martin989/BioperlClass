#!/usr/bin/perl

use strict;
use warnings;

$|++;

use Bio::DB::GenBank;
use Bio::SeqIO;
use Bio::Tools::Run::RemoteBlast;

print "Please enter an accession number:\n";
my $accession = <STDIN>;
chomp $accession;

my $genbank_dbh = Bio::DB::GenBank->new();
my $seqio = $genbank_dbh->get_Stream_by_acc($accession);
my $sequence = $seqio->next_seq();


my $factory = Bio::Tools::Run::RemoteBlast->new( -prog => 'blastn',
						 -data => 'nr',
						 -expect => '1e-3',
						 -readmethod => 'SearchIO');

print "Submitting BLAST\n";
$factory->submit_blast($sequence);

print "Checking results\n";

my $b1_acc;

FIRSTB: while(my @rids = $factory->each_rid)
{
	print ".";
	foreach my $rid (@rids)
	{
		my $result = $factory->retrieve_blast($rid);
		if(ref($result))
		{
			my $output = $result->next_result();
			$factory->remove_rid($rid);

			while(my $hit = $output->next_hit())
			{
				if($hit->accession() eq $accession)
				{
					
				}
				else
				{
					print "\n" . $hit->accession() . " is the top non-self hit for the first BLAST\n";
					$b1_acc = $hit->accession();
					last FIRSTB;
				}
			}
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

my $genbank_dbh2 = Bio::DB::GenBank->new();
my $seqio2 = $genbank_dbh2->get_Stream_by_acc($b1_acc);
my $sequence2 = $seqio2->next_seq();


my $factory2 = Bio::Tools::Run::RemoteBlast->new( -prog => 'blastn',
                                                 -data => 'nr',
                                                 -expect => '1e-3',
                                                 -readmethod => 'SearchIO');

print "Submitting second BLAST\n";
$factory2->submit_blast($sequence2);

SECONDB: while(my @rids = $factory2->each_rid)
{
        print ".";
        foreach my $rid (@rids)
        {
                my $result = $factory2->retrieve_blast($rid);
                if(ref($result))
                {
                        my $output = $result->next_result();
                        $factory2->remove_rid($rid);

                        while(my $hit = $output->next_hit())
                        {
                                if($hit->accession() eq $b1_acc)
                                {

                                }
                                else
                                {
                                        print "\n" . $hit->accession() . " is the top non-self hit for the second BLAST\n";
                                        if($hit->accession() eq $accession)
					{
						print "Second BLAST top non-self hit is same as original input\n";
					}
					print $hit->name() . "\n"
						. $hit->description() . "\n"
						. $hit->length() . "\n"
						. $hit->raw_score() . "\n"
						. $hit->significance() . "\n";
                                        last SECONDB;
                                }
                        }
                }
                elsif($result < 0)
                {
                        $factory2->remove_rid($rid);
                }
                else
                {
                        sleep 5;
                }
        }
}
