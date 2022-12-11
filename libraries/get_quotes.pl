sub get_quotes 

{

	$url = $_[0];

	my ($plain_text,$request,$response,$ua,$page);

	$ua = new LWP::UserAgent;

	require HTTP::Request;

	$request = HTTP::Request->new(GET => $url);

	$response = $ua->request($request);

	$page = $response->content;

	($plain_text = $page) =~s/<[^>]*>//gs;

	$plain_text=~s/\n//g;

	@quotes = split/(.{100})/,$plain_text;

	return @quotes;

}

1;
