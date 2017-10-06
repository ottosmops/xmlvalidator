TRANG = trang
XSLTPROC = xsltproc

all: rng schematron ;

.PHONY: clean
clean:
	rm -f schematron/mets.xsl
	rm -f relaxng/*.rng

rng: relaxng/dvlinks.rng relaxng/dvrights.rng

schematron: schematron/mets.xsl

%.xsl: %.sch
	cd util/iso-schematron-xslt1 ; $(XSLTPROC) -o ../../$@ iso_svrl_for_xslt1.xsl ../../$<

%.rng: %.rnc
	$(TRANG) -I rnc -O rng $< $@
