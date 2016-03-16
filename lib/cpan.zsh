cpan/local-shell () { perl -Mlocal::lib -MCPAN -wEshell }

cpan/distro-from-module-name () { 
    perl -MCPAN -wsne '
	BEGIN {
	    $CPAN::Frontend = q(Z);
	    sub Z::myprint {}
	    sub Z::mysleep {}
	    my $token_archive_extension = qr{
		\. (?:
		    tar.gz
		    tgz
		) $ 
	    }x;
	}
	chomp;
	next unless $_;
	if ( my $module =
	    CPAN::Shell->expand( Module => $_ )
	) {
	    print "$_ : ",  $module->distribution->pretty_id;
	    $module{ $module->distribution->pretty_id }=1;
	}
	END { print "$_\n" for sort keys %module  }
    '
}

pod/tree () {
    # treePod ~/src/perl-modules/Dancer /tmp/p
    local from=$1 to=$2
    shift 2

    for file ( $from/**/*.pod(.N) ) {
	local ext=$file:e
	local rel=${file#$from/}
	local dest=$to/${rel%$ext}html
	local title=$file:t
	
	mkdir -p $dest:h
		pod2html --header --infile=$file \
		--title=$title                   \
		--htmlroot=$to                   \
		--podroot=$from                  \
		--outfile=$dest
    }

}

p5/list-modules () {
    perl -E'-d and say for @INC' |
        xargs -IX find X -type f -name '*pm' -printf '%P\n' |
        sed 's#/#::#g; s/[.]pm$//'
}


