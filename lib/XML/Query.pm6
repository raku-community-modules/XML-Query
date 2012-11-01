use XML;

class XML::Query;

use XML::Query::Statement;

has $.xml;

multi method new (XML::Element $xml)
{
  self.new(:$xml);
}
multi method new (XML::Document $doc)
{
  my $xml = $doc.root;
  self.new(:$xml);
}
method compile ($statement)
{
  XML::Query::Statement.new($statement);
}
method postcircumfix:<( )> ($statement)
{
  self.compile(~$statement).apply($!xml);
}

