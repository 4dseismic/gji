


mc.pdf : mc.tex tp.pdf Makefile mc.bbl sl2007-vel.pdf hmE2011-vel.pdf
	pdflatex mc
tp.pdf : tp.sh
	sh tp.sh
mc.bbl : mc.bib 
	echo | pdflatex mc
	bibtex mc
clean :
	rm mc.aux mc.log mc.pdf tp.pdf mc.bbl mc.blg dump.vel gplot.input gplot.rays gplot.vel j.ray jj rays velocity 
