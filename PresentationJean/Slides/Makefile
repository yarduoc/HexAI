DOCUMENT = slides
TEX_FOLDER = tex
TEX_FILES = minimax_complexite.tex minimax_presentation.tex \
	minimax_tree.tex
STYLE = style.sty
TEX_FILES_FULL_PATH = $(addprefix $(TEX_FOLDER)/,$(TEX_FILES))


.PHONY: clean

$(DOCUMENT).pdf: $(DOCUMENT).tex $(TEX_FILES_FULL_PATH) $(STYLE)
	latexmk -pdf $(DOCUMENT).tex

clean:
	latexmk -c
	rm -f $(DOCUMENT).snm
	rm -f $(DOCUMENT).nav
