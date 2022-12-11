sub opening_page {

	my $page_data = $_[0];

	my $template = Text::Template -> new (
			-type   => "file",
                        -source => $template_one
                        );

	my $title = "Search Page";

        my $count = "0";

        open (DATABASE, "$page_data") || die ("Couldn't open file");

        while (<DATABASE>) {

                ($counter,$user_name,$request,$background,$data)=split(/\^/,$_);
                $counter[$count]=$counter;
                $user_name[$count]=$user_name;
                $request[$count]=$request;
                $background[$count]=$background;
                $data[$count]=$data;
                $data=~s/\"/\\\"/g;
                $count++;

        }

        close (DATABASE);

        $finished_page = $template -> fill_in();

	return $finished_page;

}

1;
