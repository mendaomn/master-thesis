# Config
# Source folder
SRC = ./src
# Build folder
BUILD_PATH = ./build/
# Title of the output file
OUT = thesis

# Script
# Markdown files list
MD_FILES := $(shell find $(SRC) -type f -name "*.md" | grep -v "README" | sort)
# Destination file, in PDF
DST = $(BUILD_PATH)$(OUT).pdf

# Pandoc parameters
BIBLIO = --bibliography $(SRC)/head/bibliography.bib
VARS = --variable documentclass:memoir --variable geometry:margin=1.2in --variable fontsize:12pt
PARS = --toc --number-sections --chapters --template=latex/template.tex -H latex/quote-setup.tex $(VARS)

default: build

build: clean
	pandoc $(PARS) $(MD_FILES) $(BIBLIO) -s -o tmp.tex
	sed 's/{quote}/{quotationb}/g' tmp.tex | sed '/MND.*CITES/,/MND.*CITES/d' > latex/thesis.tex
	pdflatex latex/thesis.tex && pdflatex latex/thesis.tex
	rm tmp.tex *.aux *.toc *.out
	mv thesis.* $(BUILD_PATH)

h:
	pandoc --toc --number-sections --chapters -t html5 $(MD_FILES) -c thesis.css -s -o html/thesis.html

run:
	evince $(DST) 2> /dev/null &

runh:
	google-chrome html/thesis.html

clean:
	rm -rf $(BUILD_PATH)*
	rm -f tmp.tex
	rm -f latex/thesis.*