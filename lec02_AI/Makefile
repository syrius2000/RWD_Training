# -*- mode:linum; mode:makefile-gmake -*-
.PHONY:Main

Main: aboutAI.pdf

aboutAI.pdf: aboutAI.tex
	latexmk -f -pdfdvi -logfilewarnings aboutAI

test:
	latexmk -f  -pdfdvi -logfilewarnings test.tex

clean:
	rm -rf *.*~ *.ind *.ilg *.idx *.aux *.dvi *.fdb_latexmk *.fls *.log *.nav *.out *.snm *.synctex.gz *.toc *.un~ *.vrb *~ *.bbl *.xml *.blg *.bcf *XLSgomi*

.PHONY: clean
