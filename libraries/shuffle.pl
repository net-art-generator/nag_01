# Very simple shuffle algorithim, designed by fisher & yates

sub shuffle 
{

	my $array = shift;
	my $i;

	for ($i = @$array; --$i; ) 
	
	{

		my $j = int rand ($i+1);

		next if $i == $j;

		@$array[$i,$j] = @$array[$j,$i];

	}
}

1;
