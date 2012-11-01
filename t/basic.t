#!/usr/bin/env perl6

use v6;

BEGIN { @*INC.push: './lib'; }

use Test;
use XML;
use XML::Query;

plan 10;

my $xml = from-xml(:file<./t/test1.xml>);
my $xq = XML::Query.new($xml);

my @foo = $xq('#two');

is @foo.elems, 1, 'id query returned 1 result.';
is @foo[0]<id>, 'two', 'id query element matches.';
is @foo[0].nodes.elems, 4, 'id query child element count is correct.';

my @odd = $xq('.odd');
is @odd.elems, 5, 'class query returned proper count.';
is @odd[2]<id>, 'two.1', 'class query element matches';

my @two-odd = $xq('#two .odd');
is @two-odd.elems, 2, 'nested query works';

my @two-ids = $xq('#one, #three');
is @two-ids.elems, 2, 'multiple queries works';

my @mixed = $xq('#one .even, #two .even');
is @mixed.elems, 3, 'mixed queries work';
is @mixed[0]<id>, 'one.2', 'mixed query got right element.';
is @mixed[2]<id>, 'two.4', 'mixed query got right element.';

