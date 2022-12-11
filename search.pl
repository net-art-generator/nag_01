#!/usr/bin/perl 

#use Taint;
use WWW::Search;
use LWP::UserAgent;
use HTML::LinkExtor;
use HTTP::Request;
use URI::URL;
use CGI;
use Text::Template;

require "./libraries/image_gather.pl";
require "./libraries/search_web.pl";
require "./libraries/shuffle.pl";
require "./libraries/get_quotes.pl";
require "./libraries/event_counter.pl";
require "./libraries/opening_page.pl";
require "./libraries/previous_page.pl";
require "./libraries/shift_page_data.pl";
require "./libraries/add_page.pl";

#
# Important Variables
#

$counter_file = "/web1/ryan.banff.org/cgi-bin/search/data/counter";
$template_one = "/web1/ryan.banff.org/cgi-bin/search/data/search.html";
$template_two = "/web1/ryan.banff.org/cgi-bin/search/data/template.html";
$page_data = "/web1/ryan.banff.org/cgi-bin/search/data/page_data";
$server_address = "http://ryan.banff.org/cgi-bin/search";

#
# Don't change anything after this...
#

my $query = new CGI;
my $session = $query -> param ( 'session' );
my $previous_page = $query -> param ('page' );
my $user_name = $query -> param ('name');
my $string = $query -> param ('string');

if ($string < 45) 
{ 
	if ($string =~ /[\&\;\`\'\\\"\|\*\?\~\/\<\>\^\(\)\[\]\{\}\$\r]/ )

	{
		print $query -> header();
		print "INVALID DATA";
		exit;
	}
} 
else
{
	print $query -> header();
	print "INVALID DATA";
	exit;
}

#if ($previous_page < 10)
#{
#	if ($previous_page =~ /[\&\;\`\'\\\"\*\?\~\<\>\^\(\)\[\]\{\}\$\r]/ )
#	{
#		print $query -> header();
#		print "INVALILD DATA";
#		exit;
#	}
#}
#else
#{
#	print  $query -> header();
#	print "INVALID DATA";
#	exit;
#}

######################################################
# SEARCH QUERY PAGE
######################################################

if ($session eq "") {

	my $opening_page = &opening_page($page_data);

	print $query -> header();

	print $opening_page;

	exit;

}

######################################################
# DISPLAY A PREVIOUS PAGE
######################################################

if ($session eq "previous") {

	my $previous_page = &previous_page($previous_page,$page_data,$template_two);

	print $query -> header();

	print $previous_page;

	exit;

}

######################################################
# PAGE MAKING SCREEN
######################################################

if ($session ne "") 

{

#	my $search_string = WWW::Search::escape_query($string);	

	$search_string = $string;

	@urls = &search_web($search_string);

	@pictures = &create_image_array($urls[0]);

	@quotes = &get_quotes($urls[0]);

	push (@quotes, @pictures);

	&shuffle(\@quotes);

	$event_counter = &event_counter($counter_file);

	&shift_page_data($page_data);

	&add_page(\@quotes,$event_counter,$user_name,$string,$background);

	@array = @quotes;

	$title = $search_string;

	$template = Text::Template -> new (
			-type	=>		"file",
			-source =>		$template_two
			);

	print $query -> header();

	print $template -> fill_in();

	exit;

}
