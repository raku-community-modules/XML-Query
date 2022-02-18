use XML;

unit class XML::Query::Results;
has @.results;        ## The matching elements.
has $.parent;         ## The Statement that generated these results.

method element() { @!results.head }

method elem() is DEPRECATED('.element') {
    self.element
}

method elements() {
    @!results;
}

method elems() is DEPRECATED('.elements') {
    self.elements
}

method !spawn(*@results) {
    self.new(:$.parent, :@results)
}

method first() {
    self!spawn(@!results.head)
}

method last() {
    self!spawn(@!results.tail)
}

method AT-POS($offset) {
    self!spawn(@!results[$offset])
}

method results-xml() {
    my $xml := XML::Element.craft('results');
    $xml.nodes = @!results;
    $xml
}

method find($statement) {
    $.parent.parent.compile(~$statement).apply(self.results-xml)
}

# vim: expandtab shiftwidth=4
