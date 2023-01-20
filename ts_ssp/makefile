doc:
	latex Figure_ts_fgd
	latex Figure_ts_fgd
	dvips -o Figure_ts_fgd.ps Figure_ts_fgd
	ps2epsi Figure_ts_fgd.ps Figure_ts_fgd.eps
	ps2pdf Figure_ts_fgd.eps
	make clean

clean :
	\rm -f *.$(OBJ_EXT) *.log *.aux *.fff *.bbl *.blg *.ttt *.ps 


cleanall :
	\rm -f *.$(OBJ_EXT) *.dvi *.log *.aux *.fff *.bbl *.blg *.ttt *.pdf

