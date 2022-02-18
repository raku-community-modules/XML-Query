use XML::Query::Results;

unit class XML::Query::Statement;
has $.statement;     ## The statement we represent.
has $.parent;        ## The top-level XML::Query object.

method apply($xml) {
    my @results;

    my $cattr = $.parent.class-attr;

    my @groups = $!statement.split(/','\s*/);
    for @groups -> $group {
        my @tree = $group.split(/\s+/);
        my $pos = $xml; ## We start from the root.
        my $expand = False;
        my $recurse = 999;
        for @tree -> $branch {
            if $branch eq '>' {
                $recurse = 0;
                next;
            }
            if $branch ~~ /^'#' (<ident>)/ {
                $pos .= getElementById(~$0);
                last without $pos;
                $expand = False;
            }
            elsif $branch ~~ /^'.' (<ident>)/ {
                $pos .= elements(
                  RECURSE   => $recurse,
                  OBJECT    => True,
                  |($cattr  => ~$0),
                );
                last without $pos;
                $expand = True;
            }
            elsif $branch ~~ /^(<ident>)/ {
                $pos .= getElementsByTagName(~$0, :object);
                last without $pos;
                $expand = True;
            }
            if $branch ~~ /'[' (<ident>) '=' '"'? (.*?) '"'? ']'/ {
                $pos .= elements(
                  RECURSE => $recurse,
                  OBJECT  => True,
                  |(~$0   => ~$1),
                );
                if ! $pos.defined { last; }
                $expand = True;
            }
            $recurse = 999;
        }
        next without $pos;

        $expand
          ?? @results.append($pos.nodes)
          !! @results.push($pos)
    }
    XML::Query::Results.new(:@results, :parent(self))
}

# vim: expandtab shiftwidth=4
