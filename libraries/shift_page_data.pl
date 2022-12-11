sub shift_page_data

{

	my $page_data = $_[0];

	my $line_counter = "0";

	open (DATABASE,"$page_data") || die ("Unable to load page_data, shift_page");

	while (<DATABASE>) 

	{

		$lines[$line_counter] = $_;

		$line_counter++;

	}

	close (DATABASE);

	$old = shift (@lines);

	open (DATABASE,">$page_data") || die ("Unable to load page_data, shift_page");
	
	for ($i=0 ; $i < 10 ; $i++)

	{

	print DATABASE "$lines[$i]";

	}

	close (DATABASE);


	
}

1;
