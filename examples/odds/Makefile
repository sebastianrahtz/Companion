go:
	for i in *.rng; \
	do \
	X=`basename $$i .rng`; \
	perl -p -e 's+www.tei-c.org/schema+localhost/schema+g;s/^[ ]*</</g;s/\n//g' $$i > local.$$i; \
	trang local.$$i $$X.rnc; \
	rm local.$$i; \
	perl -p -i -e 's+include "+include "http://www.tei-c.org/schema/relaxng/p5/+' $$X.rnc;\
	done
	-rm core.rnc header.rnc tei.rnc textstructure.rnc linking.rnc
