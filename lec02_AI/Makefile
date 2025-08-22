# -*- mode:linum; mode:makefile-gmake -*-
.PHONY:Main

Main:
	# latexmk -f -pv -pdfdvi -logfilewarnings aboutAI
	latexmk -f  -pdfdvi -logfilewarnings aboutAI

clean:
	rm -rf *.*~ *.ind *.ilg *.idx *.aux *.dvi *.fdb_latexmk *.fls *.log *.nav *.out *.snm *.synctex.gz *.toc *.un~ *.vrb *~ *.bbl *.xml *.blg *.bcf *XLSgomi*
	# latexmk -c aboutAI


PIC:
	latexmk -f -pdfdvi -logfilewarnings xypic
