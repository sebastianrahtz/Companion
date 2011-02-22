param: 
	saxon -o customize.xml param.xml param.xsl PATH=/TEI/Sourceforge/Stylesheets/	

battle: battle1 battle2 battle3 battle4 battle5

battle1:
	xsltproc --stringparam cssFile /usr/share/xml/tei/stylesheet/tei.css battle1.xsl battle.xml  | perl -p -i -e 's+http://www.tei-c.org/Stylesheets/teic/teixsl.png+/usr/share/doc/tei-xsl/teixsl.png+' > battle1.html

battle2:
	xsltproc --stringparam cssFile /usr/share/xml/tei/stylesheet/tei.css battle2.xsl battle.xml  | perl -p -i -e 's+http://www.tei-c.org/Stylesheets/teic/teixsl.png+/usr/share/doc/tei-xsl/teixsl.png+' > battle2.html
	xsltproc --stringparam cssFile /usr/share/xml/tei/stylesheet/tei.css battle2a.xsl battle.xml  | perl -p -i -e 's+http://www.tei-c.org/Stylesheets/teic/teixsl.png+/usr/share/doc/tei-xsl/teixsl.png+' 
	xsltproc --stringparam cssFile /usr/share/xml/tei/stylesheet/tei.css battle2b.xsl battle.xml  | perl -p -i -e 's+http://www.tei-c.org/Stylesheets/teic/teixsl.png+/usr/share/doc/tei-xsl/teixsl.png+' 

teilite:
	xsltproc --stringparam cssFile /usr/share/xml/tei/stylesheet/tei.css teilite.xsl teilite.xml  | perl -p -i -e 's+http://www.tei-c.org/Stylesheets/teic/teixsl.png+/usr/share/doc/tei-xsl/teixsl.png+' 
	xsltproc --stringparam cssFile /usr/share/xml/tei/stylesheet/tei.css teilite2.xsl teilite.xml  | perl -p -i -e 's+http://www.tei-c.org/Stylesheets/teic/teixsl.png+/usr/share/doc/tei-xsl/teixsl.png+' 

battle3:
	xsltproc --stringparam cssFile /usr/share/xml/tei/stylesheet/tei.css battle3.xsl battle.xml  | perl -p -i -e 's+http://www.tei-c.org/Stylesheets/teic/teixsl.png+/usr/share/doc/tei-xsl/teixsl.png+' > battle3.html

battle4:
	xsltproc --stringparam cssFile /usr/share/xml/tei/stylesheet/tei.css battle4.xsl battle.xml  | perl -p -i -e 's+http://www.tei-c.org/Stylesheets/teic/teixsl.png+/usr/share/doc/tei-xsl/teixsl.png+' 

battle5:
	xsltproc --stringparam cssFile /usr/share/xml/tei/stylesheet/tei.css battle5.xsl battle.xml 

troilus:
	xsltproc --stringparam cssFile /usr/share/xml/tei/stylesheet/tei.css shakespeare.xsl troilus.xml

pdflatex:
	xsltproc -o troilus.tex pdf1.xsl troilus.xml 
	pdflatex troilus
	pdflatex troilus
	mv troilus.pdf troilus.latex.pdf
	xsltproc -o hanesdiary.tex pdf1.xsl hanesdiary.xml 
	pdflatex hanesdiary
	pdflatex hanesdiary
	mv hanesdiary.pdf hanesdiary.latex.pdf
	xsltproc -o teilite.tex pdf1.xsl teilite.xml 
	pdflatex teilite
	pdflatex teilite
	mv teilite.pdf teilite.latex.pdf
	xsltproc -o battle.tex pdf1.xsl battle.xml 
	pdflatex battle
	pdflatex battle
	mv battle.pdf battle.latex.pdf

pdffo:
	xsltproc --stringparam foEngine xep -o troilus.fo pdffo.xsl troilus.xml 
	xep troilus.fo
	mv troilus.pdf troilus.xep.pdf
	xsltproc --stringparam foEngine passivetex -o troilus.fo pdffo.xsl troilus.xml 
	pdfxmltex troilus.fo
	pdfxmltex troilus.fo
	mv troilus.pdf troilus.passivetex.pdf

stop:
	xsltproc --stringparam foEngine passivetex -o hanesdiary.fo pdffo.xsl hanesdiary.xml 
	pdfxmltex hanesdiary.fo
	pdfxmltex hanesdiary.fo
	mv hanesdiary.pdf hanesdiary.passivetex.pdf
	xsltproc --stringparam foEngine xep -o hanesdiary.fo pdffo.xsl hanesdiary.xml 
	xep hanesdiary.fo
	mv hanesdiary.pdf hanesdiary.xep.pdf
	xsltproc --stringparam foEngine passivetex -o teilite.fo pdffo.xsl teilite.xml 
	pdfxmltex teilite.fo
	pdfxmltex teilite.fo
	mv teilite.pdf teilite.passivetex.pdf
	xsltproc --stringparam foEngine xep -o teilite.fo pdffo.xsl teilite.xml 
	xep teilite.fo
	mv teilite.pdf teilite.xep.pdf
	xsltproc --stringparam foEngine passivetex -o battle.fo pdffo.xsl battle.xml 
	pdfxmltex battle.fo
	pdfxmltex battle.fo
	mv battle.pdf battle.passivetex.pdf
	xsltproc --stringparam foEngine xep -o battle.fo pdffo.xsl battle.xml 
	xep battle.fo
	mv battle.pdf battle.xep.pdf



clean:
	-rm *.html *~ *.fo *.out *.log *.tex *.aux
	-rm *.latex.pdf *.xep.pdf *.passivetex.pdf

