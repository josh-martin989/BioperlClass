package q8;

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = ( "translate_dna" );

sub translate_dna
{
	my ($dna) = @_;
	my %codons = (TTT => "F", TTC => "F", TTA => "L", TTG => "L",
			CTT => "L", CTC => "L", CTA => "L", CTG => "L",
			ATT => "I", ATC => "I", ATA => "I", ATG => "M",
			GTT => "V", GTC => "V", GTA => "V", GTG => "V",
			TCT => "S", TCC => "S", TCA => "S", TCG => "S",
			CCT => "P", CCC => "P", CCA => "P", CCG => "P",
			ACT => "T", ACC => "T", ACA => "T", ACG => "T",
			GCT => "A", GCC => "A", GCA => "A", GCG => "A",
			TAT => "Y", TAC => "Y", CAT => "H", CAC => "H",
			CAA => "Q", CAG => "Q", AAT => "N", AAC => "N",
			AAA => "K", AAG => "K", GAT => "D", GAC => "D",
			GAA => "E", GAG => "E", TGT => "C", TGC => "C",
			TGG => "W", CGT => "R", CGC => "R", CGA => "R",
			CGG => "R", AGT => "S", AGC => "S", AGA => "R",
			AGG => "R", GGT => "G", GGC => "G", GGA => "G",
			GGG => "G");
	my $seq = uc($dna);
	if($seq =~ /[^ACTG]+/)
	{
		print "Input string contains non-nucleotide character\n";
		return "";
	}

	if(!($seq =~ /ATG/))
	{
		print "Input sequence does not contain a start codon\n";
		return "";
	}

	my $start_pos;
	for(my $i = 0; $i <= (length($seq) - 3); $i++)
	{
		if(substr($seq, $i, 3) eq "ATG")
		{
			$start_pos = $i;
			last;
		}
	}
	
	my $iter = $start_pos;
	my $ret_seq = "";
	while($iter <= (length($seq) - 3))
	{
		my $triplet = substr($seq, $iter, 3);
		if(($triplet eq "TAA") || ($triplet eq "TAG") || ($triplet eq "TGA"))
		{
			last;
		}
		$ret_seq .= $codons{$triplet};
		$iter = $iter + 3;
	}

	return $ret_seq;
}



1;
