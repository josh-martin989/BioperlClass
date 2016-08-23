#!/usr/bin/perl

use strict;
use warnings;

$|++;

use Bio::DB::GenBank;
use Bio::SeqIO;
use Bio::Tools::Run::RemoteBlast;

my $accession = $ARGV[0];
my $evalue = $ARGV[1];

my $genbank_dbh = Bio::DB::GenBank->new();
my $seqio = $genbank_dbh->get_Stream_by_acc($accession);
my $sequence = $seqio->next_seq();

my $factory = Bio::Tools::Run::RemoteBlast->new( -prog => 'blastp',
                                                 -data => 'nr',
                                                 -expect => "$evalue",
                                                 -readmethod => 'SearchIO');

print "Submitting BLAST\n";
$factory->submit_blast($sequence);

CHECK: while(my @rids = $factory->each_rid)
{
        print ".";
        foreach my $rid (@rids)
        {
                my $result = $factory->retrieve_blast($rid);
                if(ref($result))
                {
                        my $output = $result->next_result();
                        $factory->remove_rid($rid);
			
			my $bool = "false";
			while(my $hit = $output->next_hit())
			{
				my $new_acc = $hit->accession();
				my $get_seq = $genbank_dbh->get_Stream_by_acc($new_acc);
				my $out_IO = Bio::SeqIO->new( -file => "> $new_acc.fasta" , -format => 'fasta');
				$out_IO->write_seq($get_seq->next_seq());
				$bool = "true";
				sleep 2;
			}
			if($bool eq "false")
			{
				print "No hits satisfying given e-value cutoff\n";
				last CHECK;
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
