#!/usr/bin/perl

use Bio::SeqIO;

my $infile = $ARGV[0];
my $convert_to = $ARGV[1];

my %ext;
$ext{ab1} = "ab1";
$ext{abi} = "abi";
$ext{alf} = "alf";
$ext{ctf} = "ctf";
$ext{embl} = "embl";
$ext{exp} = "exp";
$ext{fasta} = "fasta";
$ext{fas} = "fasta";
$ext{fastq} = "fastq";
$ext{gcg} = "gcg";
$ext{genbank} = "genbank";
$ext{gb} = "genbank";
$ext{pir} = "pir";
$ext{pln} = "pln";
$ext{scf} = "scf";
$ext{ztr} = "ztr";
$ext{ace} = "ace";
$ext{game} = "game";
$ext{locuslink} = "locuslink";
$ext{ll_tmpl} = "locuslink";
$ext{phd} = "phd";
$ext{qual} = "qual";
$ext{raw} = "raw";
$ext{swiss} = "swiss";

my $from;
$infile =~ /^(.+)\.([a-zA-Z_]+)$/;
if(exists($ext{lc($2)}))
{
	$from = $ext{lc($2)};
}
else
{
	print "invalid input format. Please change the extension to a format readable by Bio::SeqIO\n";
	exit;
}

my $bool = "false";
foreach my $to_format (values(%ext))
{
	if(lc($convert_to) eq $to_format)
	{
		$bool = "true";
		last;
	}
}

if($bool eq "true")
{
	my $outfile = "$1.$convert_to";
	my $in_seqio = Bio::SeqIO->new( -file => $infile , -format => "$from" );
	my $out_seqio = Bio::SeqIO->new( -file => "> $outfile" , -format => "$convert_to" );
	while(my $seq = $in_seqio->next_seq())
	{
		$out_seqio->write_seq($seq);
	}
	print "Wrote $outfile\n";
}
else
{
	print "invalid output type. Please chose a format accepted by Bio::SeqIO\n";
}
