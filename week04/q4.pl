#!/usr/bin/perl

use strict;
use warnings;

use Test::Simple tests => 4;

use q3 'gen_random';


my $length = 50;
my $random_dna_1param = gen_random($length);

my $random_dna_2param = gen_random($length, "True");
my $length2 = length($random_dna_2param);

ok( length($random_dna_1param) == $length , "gen_random produces correct length with 1 param" );
ok( (length($random_dna_2param) <= $length) && (length($random_dna_2param) >= 1), "gen_random produces an acceptable length with 2 params");

ok( $random_dna_1param =~ /^[ATCG]{$length}$/i , "gen_random with 1 param produces a string containing only DNA base letters");
ok( $random_dna_2param =~ /^[ATCG]{$length2}$/i , "gen_random with 2 params produces a string containing only DNA base letters");
