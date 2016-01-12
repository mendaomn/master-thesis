# Config
# Source folder
SRC = ./src
# Build folder
BUILD_PATH = ./build
# Title of the output file
OUT = thesis

# Script
# Markdown files list
MD_FILES := $(shell find $(SRC) -type f -name "*.md" | grep -v "README" | sort)
# Destination file, in PDF
DST = $(BUILD_PATH)$(OUT).pdf

# Pandoc parameters
BIBLIO = --bibliography $(SRC)/content/head/bibliography.bib
VARS = --variable documentclass:memoir --variable geometry:margin=1.2in --variable fontsize:12pt
HEADERS = -H $(SRC)/latex/colors.tex -H $(SRC)/latex/quote-setup.tex -H $(SRC)/latex/code-snippets-setup.tex -H $(SRC)/latex/chapter-setup.tex
BODY_START = -B $(SRC)/latex/frontcover.tex
PARS = --toc --number-sections --chapters --template=$(SRC)/latex/template.tex $(HEADERS) $(BODY_START) $(VARS)

default: build

build: clean
	pandoc $(PARS) $(MD_FILES) $(BIBLIO) -s -o tmp.tex
	sed 's/{quote}/{quotationb}/g' tmp.tex | sed '/MND.*CITES/,/MND.*CITES/d' > $(SRC)/latex/thesis.tex
	pdflatex $(SRC)/latex/thesis.tex && pdflatex $(SRC)/latex/thesis.tex
	rm tmp.tex *.aux *.toc *.out
	mv thesis.* $(BUILD_PATH)

h:
	mkdir $(BUILD_PATH)/html
	pandoc --toc --number-sections --chapters -t html5 $(MD_FILES) -c thesis.css -s -o $(BUILD_PATH)/html/thesis.html

run:
	evince $(DST) 2> /dev/null &

runh:
	google-chrome $(BUILD_PATH)/html/thesis.html

clean:
	find $(BUILD_PATH) -maxdepth 1 -type f -exec rm {} \; 
	rm -f tmp.tex
	rm -f $(SRC)/latex/thesis.*