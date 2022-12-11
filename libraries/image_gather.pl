
sub create_image_array {

	$url = $_[0];

#	print "\n making a list of image array's from those pages \n";

	@imgs = ();

	$ua = new LWP::UserAgent;

	$p = HTML::LinkExtor -> new (\&callback);

	require HTTP::Request;

	$res = $ua -> request 
		( HTTP::Request -> 	new ( GET => $url ),
					sub { 
						$p->parse($_[0])
					} 
		);

	my $base = $res -> base;

	@imgs = map {
	
		$_ = url( $_, $base) -> abs;

		} @imgs;

	my $image_counter = 0;

	foreach $image (@imgs) {

		if ($image =~/jpg$|jpeg$|gif$|png$|JPG$|JPEG$/){

			if ($image_counter eq "0") {

				$background = $image;

				}

			$pictures[$image_counter] = "<img src=\"";
			$pictures[$image_counter] .= $image;
			$pictures[$image_counter] .= "\">";

			$image_counter++;

		}
	}

return @pictures;

}

# Subroutines for this library...

sub callback 
{

	my ($tag, %attr) = @_;

	retrun if $tag ne 'img';

	push (@imgs, values %attr);

}

1;
