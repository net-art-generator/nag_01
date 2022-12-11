sub add_page

{

	my ($x) = @_;

	my @quotes = @$x;

	my $new_counter = $_[1];

	my $user_name = $_[2];

	my $title = $_[3];

	$background = $_[4];

	$saved_array = join ("|",@quotes);
	
	$data = $new_counter;		$data .= "^";
	$data .= $user_name;		$data .= "^";
	$data .= $title;		$data .= "^";
	$data .= $background;		$data .= "^";
	$data .= $saved_array;		$data .= "^";


	open (DATABASE, ">>$page_data") || die ("died at add_page 1");
	
	print DATABASE "$data\n";

	close (DATABASE);



	
}

1;
