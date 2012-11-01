# XML::Query

## Introduction

XML::Query is a jQuery-like XML query engine for Perl 6.
It works with the [XML](https://github.com/supernovus/exemel) library 
to provide a flexible and easy method of querying for specific XML/XHTML nodes.

I haven't fully mapped out the full spec for this, but the idea is to have
chainable queries. To do this, the XML::Query object will return
XML::Query::Result objects, which in turn support certain sub-queries,
such as 'not', 'first', 'last', 'eq', 'closest', 'children', 'parent', etc.

Unlike jQuery, XML::Query is for querying and travsersing XML structures only, 
and does not support direct manipulation of XML data (however you can use the
features inherent to the XML library to manipulate the data.)

## Synopsis

```perl
  ## Given $xml is an XML::Document or XML::Element object.
  my $xq = XML::Query.new($xml);
  my @radio-boxes = $xq('input[type="radio"]').not(':first').elems;
  my $first-link = $xq('a').first;
  my $by-id = $xq('#header').elem;
  my $last-decr-class = $xq('.decr').last;
```

## Status

This is a work in progress. It's very much under construction and not
much works yet. Currently everything that works and has been tested can
be seen in the tests in the 't/' folder.

## Author

[Timothy Totten](https://github.com/supernovus/)

## License

[Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0)

