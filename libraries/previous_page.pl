sub previous_page 
{
	my ($previous_page, $page_data, $template_two);

	$previous_page = $_[0];

	$page_data = $_[1];

	$template_two = $_[2];

	open (DATABASE, "$page_data") || die ("couldn't open file, previous_page 1");

	while (<DATABASE>) 
	{

		($counter,$user_name,$drequest,$dbackground,$ddata)=split(/\^/,$_);

		if ($counter eq $previous_page) 
	
		{
			$title = $drequest;
			$background = $dbackground;
			$full_data = $ddata;
		}

	}

	close (DATABASE);

	@array = split/\|/, $full_data;

	$template = Text::Template -> new (
			-type	=>	"file",
			-source =>	$template_two
			);

	$previous_page = $template -> fill_in();

	return $previous_page;
}
1;
