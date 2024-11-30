[![Actions Status](https://github.com/raku-community-modules/XML-Query/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/XML-Query/actions) [![Actions Status](https://github.com/raku-community-modules/XML-Query/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/XML-Query/actions) [![Actions Status](https://github.com/raku-community-modules/XML-Query/actions/workflows/windows.yml/badge.svg)](https://github.com/raku-community-modules/XML-Query/actions)

NAME
====

XML::Query - jQuery-like node selecting and traversing for XML

SYNOPSIS
========

```raku
use XML::Query;

## Given $xml is an XML::Document or XML::Element object.
my $xq = XML::Query.new($xml);
my @boxes = $xq('input[type="radio"]').not('[disabled="disabled"]').elements;
my $first-link = $xq('a').first.element; 
my $by-id = $xq('#header').element;
my $last-decr-class = $xq('.decr').last.element;
```

DESCRIPTION
===========

XML::Query is a jQuery-like XML query engine for Raku. It works with the [XML](https://github.com/raku-community-modules/XML) library to provide a flexible and easy method of querying for specific XML/XHTML nodes.

Unlike jQuery, `XML::Query` is for querying and travsersing XML structures only, and does not support direct manipulation of XML data (however you can use the features inherent to the XML library to manipulate the data.)

STATUS
======

This is a work in progress. It doesn't support many methods or selectors yet, and there is no documentation. See the tests in the "t/" folder for examples of what does work so far.

AUTHOR
======

Timothy Totten

Source can be located at: https://github.com/raku-community-modules/XML-Query . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2012 - 2017 Timothy Totten

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

