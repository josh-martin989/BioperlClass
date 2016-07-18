#!/usr/bin/perl

use strict;
use warnings;

use CGI(':standard');
use DBI;

my $title = 'Midterm Question 10';
print header,
     start_html($title),
     h1($title);

if(param('submit'))
{
	my $dbh = DBI->connect("DBI:SQLite:dbname=../week06/q1.dbl") or die "Cannot connect: $DBI::errstr";
        my $gname = param('gname');
	my $organism = param('organism');
	my $tissue = param('tissue');
	my $ltgteq = param('ltgteq');
	my $evalue = param('evalue');

	if(($gname eq "") && ($organism eq "") && ($tissue eq "") && ($evalue eq ""))
	{
		print p("Please enter at least one search parameter.");
	}
	else
	{
		my $select = "SELECT * FROM expression, gene, organism, rna, tissue WHERE gene.source_org=organism.oid AND expression.eid=gene.gid AND gene.gid=rna.transcript_id AND expression.eid=tissue.tid AND ";
		if($gname ne "")
		{
			$select .= "gene.name LIKE %$gname% AND ";
		}
		if($organism ne "")
		{
			$select .= "organism.latin_name LIKE %$organism% AND ";
		}
		if($tissue ne "")
		{
			$select .= "tissue.name LIKE %$tissue% AND ";
		}
		if($evalue ne "")
		{
			$select .= "expression.elevel $ltgteq $evalue AND ";
		}

		$select = substr($select, 0, (length($select) - 4));

		my $sth = $dbh->prepare($select);
		$sth->execute();
		while(my @row = $sth->fetchrow_array())
		{
			my $print_row = "";
			foreach(@row)
			{
				$print_row .= "$_\t";
			}
			print p($print_row);
		}
		$sth->finish();
	}

	$dbh->disconnect();
}


my $url = url();
print start_form(-method => 'GET', action => $url),
     p("Gene name: " . textfield(-name => 'gname')),
     p("Organism: " . textfield(-name => 'organism')),
     p("Tissue Type: " . textfield(-name => 'tissue')),
     p("Expression level: " . radio_group(-name => 'ltgteq', -values => ['<', '>', '=']) . textfield(-name => 'evalue')),
     p(submit(-name => 'submit', value => 'Submit')),
     end_form(),
     end_html();
