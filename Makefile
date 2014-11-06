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

wrap-global.pdf: wrap-global.tex $(SOURCE)
	xelatex -no-pdf wrap-global 
	bibtex -min-crossrefs=200 wrap-global
	xelatex  -no-pdf wrap-global
	makeindex -o wrap-global.snd wrap-global.sdx
	makeindex -o wrap-global.lnd wrap-global.ldx
	makeindex -o wrap-global.and wrap-global.adx
#	makeindex -o wrap-global.wnd wrap-global.wdx
#	LSP/bin/reverse-index <wrap-global.wdx >wrap-global.rdx
#	makeindex -o wrap-global.rnd wrap-global.rdx 	
	makeindex -o wrap-global.and wrap-global.combined.adx
	xelatex -no-pdf wrap-global 
	xelatex wrap-global 


 

clean:
	rm -f *.bak *~ *.log *.blg *.bbl *.aux *.toc *.cut *.out *.tmp *.tpm *.adx *.adx.hyp *.idx *.ilg *.ind \
	*.and *.glg *.glo *.gls *.wdx *.wnd *.wrd *.wdv *.ldx *.lnd *.rdx *.rnd *.xdv 

realclean: clean
	rm -f *.dvi *.ps *.pdf



