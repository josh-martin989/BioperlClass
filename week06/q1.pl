#!/usr/bin/perl

use strict;
use warnings;

use DBI;

open(my $readfile , "data.fasta") or die "could not read data.fasta\n";

my @data;

while(<$readfile>)
{
	my $rm_windows_cr = $_;
	$rm_windows_cr =~ s/\r//;	#remove windows carriage return from data.fasta
	chomp $rm_windows_cr;
	push(@data, $rm_windows_cr);
}

close($readfile);

my $iter = 0;
my %data_hash;
while($iter < scalar(@data))	#parse fasta into a hash
{
	if($data[$iter] =~ /^>/)
	{
		my $entry = $data[$iter];
		my $sequence = "";
		$iter++;
		while(($iter < scalar(@data)) && ($data[$iter] ne ""))
		{
			$sequence .= $data[$iter];
			$iter++;
		}
		$iter++;
		$data_hash{$entry} = $sequence;
	}
}

#DATABASE SECTION
my $dbh = DBI->connect("DBI:SQLite:dbname=q1.dbl") or die "Cannot connect: $DBI::errstr";

#Schema
$dbh->do("DROP TABLE IF EXISTS gene");
$dbh->do("DROP TABLE IF EXISTS organism");
$dbh->do("DROP TABLE IF EXISTS rna");
$dbh->do("DROP TABLE IF EXISTS expression");
$dbh->do("DROP TABLE IF EXISTS tissue");

$dbh->do("CREATE TABLE gene (gid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
				name VARCHAR(255) NOT NULL,
				sequence TEXT,
				source_org INTEGER)");
$dbh->do("CREATE TABLE organism (oid INTEGER NOT NULL PRIMARY KEY,
					latin_name VARCHAR(255))");
$dbh->do("CREATE TABLE rna (transcript_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
				gid INTEGER,
				start INTEGER,
				stop INTEGER)");
$dbh->do("CREATE TABLE expression (eid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
					elevel INTEGER)");
$dbh->do("CREATE TABLE tissue (tid INTEGER NOT NULL PRIMARY KEY,
				name VARCHAR(255))");

my %orgs;
my %tissues;
foreach my $seq (keys(%data_hash))
{
	$seq =~ /> (.+)/;
	my @split = split('\|', $1);
	my $org = $split[1];
	chomp $org;
	if(!(exists($orgs{$org})))
	{
		$orgs{$org} = 1;
	}
	my $tis = $split[2];
	chomp $tis;
	if(!(exists($tissues{$tis})))
	{
		$tissues{$tis} = 1;
	}
}

my $count = 1;
foreach (keys(%orgs))
{
	$orgs{$_} = $count;
	$dbh->do("INSERT INTO organism VALUES($count, '$_')");
	$count++;
}

$count = 1;
foreach (keys(%tissues))
{
	$tissues{$_} = $count;
	$dbh->do("INSERT INTO tissue VALUES($count, '$_')");
	$count++;
}

$iter = 1;
foreach my $ent (keys(%data_hash))
{
	$ent =~ /> (.+)/;
	my @split = split('\|', $1);
	my $name = $split[0];
	chomp $name;
	my $o = $split[1];
	chomp $o;
	$dbh->do("INSERT INTO gene VALUES(NULL, '$name', '$data_hash{$ent}', $orgs{$o})");
	my $start = $split[3];
	chomp $start;
	my $stop = $split[4];
	chomp $stop;
	$dbh->do("INSERT INTO rna VALUES(NULL, $iter, $start, $stop)");
	my $expression = $split[5];
	chomp $expression;
	$dbh->do("INSERT INTO expression VALUES(NULL, $expression)");
	$iter++;
}

$dbh->disconnect();
