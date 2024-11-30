use XML;
use XML::Query::Statement;

unit class XML::Query:ver<1.1>:auth<zef:raku-community-modules>;
has $.xml;
has $.class-attr = 'class';

multi method new(XML::Element $xml, *%opts) {
    self.new(:$xml, |%opts)
}

multi method new(XML::Document $doc, *%opts) {
    self.new(:xml($doc.root), |%opts)
}

method compile($statement) {
    XML::Query::Statement.new(:$statement, :parent(self))
}

method apply($statement) {
    self.compile($statement).apply($!xml)
}

method AT-KEY($statement) {
  self.apply($statement.join(' '))
}

method CALL-ME($statement) {
    self.apply($statement.join(','));
}

=begin pod

=head1 NAME

XML::Query - jQuery-like node selecting and traversing for XML

=head1 SYNOPSIS

=begin code :lang<raku>

use XML::Query;

## Given $xml is an XML::Document or XML::Element object.
my $xq = XML::Query.new($xml);
my @boxes = $xq('input[type="radio"]').not('[disabled="disabled"]').elements;
my $first-link = $xq('a').first.element; 
my $by-id = $xq('#header').element;
my $last-decr-class = $xq('.decr').last.element; 

=end code

=head1 DESCRIPTION

XML::Query is a jQuery-like XML query engine for Raku.
It works with the L<XML|https://github.com/raku-community-modules/XML>
library to provide a flexible and easy method of querying for
specific XML/XHTML nodes.

Unlike jQuery, C<XML::Query> is for querying and travsersing XML
structures only, and does not support direct manipulation of XML
data (however you can use the features inherent to the XML library
to manipulate the data.)

=head1 STATUS

This is a work in progress. It doesn't support many methods or selectors yet,
and there is no documentation. See the tests in the "t/" folder for examples
of what does work so far.

=head1 AUTHOR

Timothy Totten

Source can be located at: https://github.com/raku-community-modules/XML-Query .
Comments and Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2012 - 2017 Timothy Totten

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
