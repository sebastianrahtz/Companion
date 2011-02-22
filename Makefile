html:
	xsltproc --xinclude teicomp-html.xsl teicomp.xml > teicomp.html 

tex:
	xsltproc --xinclude -o teicomp.tex teicomp.xsl teicomp.xml

pdf: tex
	pdflatex teicomp
	pdflatex teicomp

oldtex:
	xsltproc -o teicomp.tex teicomp-latex.xsl teicomp.xml
oldpdf: tex
	LOCALTEXMF=/home/rahtz/LGC2/texmf pdflatex teicomp
	LOCALTEXMF=/home/rahtz/LGC2/texmf pdflatex teicomp

expand:
	xmllint --noent teicomp.xml > teicomp_all.xml

schema: 
	roma --xsl=/usr/share/xml/tei/stylesheet --localsource=/home/rahtz/TEI/Sourceforge/trunk/P5/Source/Guidelines/en/guidelines-en.xml teicomp.odd . 

validate:
	for i in part*xml; do rnv teicomp.rnc $$i;done
	jing teicomp.rng teicomp.xml

clean:
	-rm *~ */*~ */*/*~ teicomp_all.xml LOG TAGS
	-rm *.xsd *.rnc teicomp.dtd teicomp.compiled.odd
	-rm *.tex *.aux *.log *.out *.toc *.layout
	-rm teicomp.html teicomp.pdf texexec.*
	-(cd examples/ms; make clean)
	-(cd examples/odds; make clean)
	-(cd examples/teixsl; make clean)
