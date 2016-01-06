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
PARS = --toc --number-sections --chapters

default: build

build: clean
	pandoc $(PARS) $(MD_FILES) -s -o $(DST)

run:
	evince $(DST) 2> /dev/null &

clean:
	rm -rf $(BUILD_PATH)*
