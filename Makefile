# specify your main target here:
all: wrap-global.pdf

# specify the main file and all the files that you are including
SOURCE=authors.tex \
bibtex.tex \
conversion.tex \
indexers.tex \
latex.tex \
openness.tex \
proofreaders.tex \
serieseditors.tex \
showcases.tex \
typesetters.tex \
volumeeditors.tex\
lsp-guidelines.bib \
LSP/langsci.cls 

# irgendwie braucht man vier mal latex, weil sonst die Seiten nicht stimmen

# http://tex.stackexchange.com/questions/8791/speeding-up-latex-compilation
# xelatex danish
# 58.509u 5.358s 1:00.76 105.0%	0+0k 2+388io 0pf+0w

# xelatex -no-pdf danish
# 27.946u 0.379s 0:28.39 99.7 

wrap-global.pdf: wrap-global.tex $(SOURCE)
	xelatex -no-pdf wrap-global 
	bibtex -min-crossrefs=200 wrap-global
	xelatex  -no-pdf wrap-global
	makeindex -o wrap-global.ind wrap-global.idx
	makeindex -o wrap-global.lnd wrap-global.ldx
#	makeindex -o wrap-global.wnd wrap-global.wdx
#	LSP/bin/reverse-index <wrap-global.wdx >wrap-global.rdx
#	makeindex -o wrap-global.rnd wrap-global.rdx 
	authorindex -i -p wrap-global.aux > wrap-global.bib.adx
	sed 's/|hyperpage//' wrap-global.adx > wrap-global.txt.adx 
	cat wrap-global.bib.adx wrap-global.txt.adx > wrap-global.combined.adx
#	sed -e 's/}{/|hyperpage}{/g' wrap-global.adx > wrap-global.adx.hyp
	makeindex -o wrap-global.and wrap-global.combined.adx
	xelatex -no-pdf wrap-global 
	xelatex wrap-global 


 

clean:
	rm -f *.bak *~ *.log *.blg *.bbl *.aux *.toc *.cut *.out *.tmp *.tpm *.adx *.adx.hyp *.idx *.ilg *.ind \
	*.and *.glg *.glo *.gls *.wdx *.wnd *.wrd *.wdv *.ldx *.lnd *.rdx *.rnd *.xdv 

realclean: clean
	rm -f *.dvi *.ps *.pdf



