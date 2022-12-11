
sub search_web {

	my $string = $_[0];

	#debuging
	#$string = "wayne gretzkey";

	# This all broke around summer of 2002. oh well,
	# it lasted for almost 4 years !
	#
	#require WWW::Search;
	#$sEngine = "AltaVista";
        #$search = new WWW::Search($sEngine);
	#my $sQuery = WWW::Search::escape_query($string);
	#my $sQuery = quotemeta($string); 
	#
	
	use WWW::Search;	
	my $search = new WWW::Search('HotBot');
	my $sQuery = WWW::Search::escape_query($string);
	my $counter = "0";
	$search -> native_query($sQuery);
	#use Data::Dumper; print Dumper($search);
#	$search -> timeout(1000);
#	$search -> maximum_to_retrieve(50);
	my @results = $search -> results();

	#my @results;
	#while ($Result = $search->next_result()) {
	#	print $Result->url;
	#	print $sQuery;
	#	push @results, [$Result->url];
	#}

	#print "reached here!";
	#use Data::Dumper; print Dumper(@results);
	#exit;
	my @links;
	
	foreach my $result (@results) 
	{
		$links[$counter] = $result -> url();
		$counter++;
	}

	srand($$^time);

	my $random = int(rand($counter));

	my @urls = ($links[eval(int(rand($counter)))],
        	$links[eval(int(rand($counter)))],
        	$links[eval(int(rand($counter)))]);

	unless ($urls[1] ne $urls[0]) 
	{
		$urls[1] = ($links[eval(int(rand($counter)))]);
	}

	unless ($urls[2] ne $urls[1]) 
	{
		$urls[1] = ($links[eval(int(rand($counter)))]);
	}

	return @urls;

}

1;
