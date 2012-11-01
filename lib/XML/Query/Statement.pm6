class XML::Query::Statement;

use XML;
#use XML::Query::Result;

has $.statement;

multi method new ($statement)
{
  self.new(:$statement);
}

method apply ($xml)
{
  my @results;

  my @groups = $!statement.split(/','\s*/);
  for @groups -> $group
  {
    my @tree = $group.split(/\s+/);
    my $pos = $xml; ## We start from the root.
    my $expand = False;
    for @tree -> $branch
    {
      if $branch ~~ /^'#' (<ident>)/
      {
        my $id = ~$0;
        $pos .= getElementById($id);
        if ! $pos.defined { last; }
        $expand = False;
      }
      elsif $branch ~~ /^'.' (<ident>)/
      {
        my $class = ~$0;
        my %query =
        {
          RECURSE => 999,
          OBJECT  => True,
          'class' => $class,
        };
        $pos .= elements(|%query);
        if ! $pos.defined { last; }
        $expand = True;
      }
      elsif $branch ~~ /^(<ident>)/
      {
        my $tag = ~$0;
        $pos .= getElementsByTagName($tag, :object);
        if ! $pos.defined { last; }
        $expand = True;
      }
      if $branch ~~ /'[' (<ident>) '=' '"'? (.*?) '"'? ']'/
      {
        my $key = ~$0;
        my $val = ~$1;
        my %query =
        {
          RECURSE => 999,
          OBJECT  => True,
          $key    => $val,
        };
        $pos .= elements(|%query);
        if ! $pos.defined { last; }
        $expand = True;
      }
    }
    if ! $pos.defined { next; }
    if $expand
    {
      @results.push: $pos.nodes;
    }
    else
    {
      @results.push: $pos;
    }
  }
  return @results; ## TODO: return an XML::Query::Result object.
}

