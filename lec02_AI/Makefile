# -*- mode:linum; mode:makefile-gmake -*-
.PHONY:Main

Main:
	# latexmk -f -pdfdvi -logfilewarnings aboutAI
	latexmk -f  -pdfdvi -logfilewarnings aboutAI

test:
	latexmk -f  -pdfdvi -logfilewarnings test.tex

clean:
	rm -rf *.*~ *.ind *.ilg *.idx *.aux *.dvi *.fdb_latexmk *.fls *.log *.nav *.out *.snm *.synctex.gz *.toc *.un~ *.vrb *~ *.bbl *.xml *.blg *.bcf *XLSgomi*
	# latexmk -c aboutAI

PIC:
	latexmk -f -pdfdvi -logfilewarnings xypic
