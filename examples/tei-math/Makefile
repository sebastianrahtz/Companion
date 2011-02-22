html:
	xsltproc --stringparam verbose true -o index.html teimathml.xsl teimathml.xml

schema:
	roma --teiserver=http://localhost/Query/ teimathml.odd .

validate:
	rnv teimathml.rnc teimathml.xml

clean:
	-rm *.html
	-rm *.dtd *.xsd teimathml.rng *.rnc

