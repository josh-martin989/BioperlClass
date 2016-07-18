#!/usr/bin/perl

use strict;
use warnings;

use Test::Simple tests => 5;

use q8 'translate_dna';


my $test1_seq = "atgccggaccgcagcggtactgggtttgtgtccttgagctga";
my $test1_prot = translate_dna($test1_seq);
print "$test1_prot\n";

my $test2_seq = "TACGTGCATGCTAGTAGCTCGGTAAACGTCCGCATCCGTCGT";
my $test2_prot = translate_dna($test2_seq);
print "$test2_prot\n";

my $test3_seq = "GCACTGCACTATGACAAGCGGCAAAACTTCTGGGTATGTTCTTT";
my $test3_prot = translate_dna($test3_seq);
print "$test3_prot\n";

my $test4_seq = "ATTACGCGGCATTTGCGCAACGCACGAGGGGAGCAGTGGTCGCCT";
my $test4_prot = translate_dna($test4_seq);
print "$test4_prot";

my $test5_seq = "CGTGATZZZZACTTTAATGTGCTGCATAGCTGAGTGCTGTGTATGA";
my $test5_prot = translate_dna($test5_seq);
print "$test5_prot\n";


ok( $test1_prot =~ /^M[ARNDBCQEZGHILKMFPSTWYV]*$/ , "handles lower case input sequence" );
ok( ($test2_prot =~ /^M[ARNDBCQEZGHILKMFPSTWYV]*$/) && (length($test2_prot) <= (length($test2_seq)/3)), "Handles ORF in middle of sequence");
ok( ($test3_prot =~ /^M[ARNDBCQEZGHILKMFPSTWYV]*$/) && (length($test3_prot) <= (length($test3_seq)/3)), "Returns translation up to end of sequence when have start but no stop");
ok( $test4_prot eq "" , "Fails when start codon missing");
ok( $test5_prot eq "" , "Returns empty string when input contains non-nucleotide");
