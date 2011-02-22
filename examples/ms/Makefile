html:
	xsltproc --stringparam verbose true -o index.html eets.xsl eets.xml

schema:
	roma --teiserver=http://localhost/Query/ eets.odd .

validate:
	rnv eets.rnc eets.xml

clean:
	-rm *.html
	-rm eets.rnc eets.dtd eets.rng eets.xsd xml.xsd
