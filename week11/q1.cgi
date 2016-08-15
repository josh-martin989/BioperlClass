#!/usr/bin/perl

use strict;
use warnings;

use CGI(':standard');
use LWP::Simple;
use URI::Escape;
use XML::Simple(':strict');

my $title = 'Week 11 Question 1';
print header,
	start_html($title),
	h1($title);

if(param('submit'))
{
	my $query = param('query');
	print p("Query '$query' Results: ");
	my $url_query = uri_escape($query);
	my $base_url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/egquery.fcgi?term=$url_query";
	$base_url .= "&retmode=xml";
	my $xml = get($base_url);
	my $parse = XMLin($xml, KeyAttr => { ResultItem => 'DbName' }, ForceArray => [ 'ResultItem' ]);

	foreach my $key (keys(%{$parse->{eGQueryResult}->{ResultItem}}))
	{
		print p("$parse->{eGQueryResult}->{ResultItem}->{$key}->{MenuName}: $parse->{eGQueryResult}->{ResultItem}->{$key}->{Count}");
	}
}

my $url = url();
print start_form(-method => 'GET', action => $url),
	p("Search Query: " . textfield(-name => 'query')),
	p(submit(-name => 'submit', value => 'Submit')),
	end_form(),
	end_html();
