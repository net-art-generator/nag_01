sub event_counter 
{

	my $counter_file = $_[0];
	
	open(COUNTER, "$counter_file") || die ("Unable to open counter");

	while (<COUNTER>) 
	{

		($counter_number) = split(/\|/,$_);

	}

	close (COUNTER);

	$new_counter = $counter_number;

	$new_counter++;

	$new_counter .= "|";

	open (COUNTER,">$counter_file") || die ("Unable to open counter.");

	print COUNTER "$new_counter";

	close (COUNTER);

	return $new_counter;
}
1;
