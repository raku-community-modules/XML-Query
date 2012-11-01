use XML;

class XML::Query;

use XML::Query::Statement;

has $.xml;
has $.class-attr = 'class';

multi method new (XML::Element $xml, *%opts)
{
  self.new(:$xml, |%opts);
}
multi method new (XML::Document $doc, *%opts)
{
  my $xml = $doc.root;
  self.new(:$xml, |%opts);
}

method compile ($statement)
{
  XML::Query::Statement.new(:$statement, :parent(self));
}

method postcircumfix:<( )> ($statement)
{
  self.compile(~$statement).apply($!xml);
}

