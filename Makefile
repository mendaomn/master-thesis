# Config
# Source folder
SRC = ./src
# Build folder
BUILD_PATH = ./build/
# Title of the output file
OUT = thesis

# Script
MD_FILES := $(shell find $(SRC) -type f -name "*.md" | grep -v "README" | sort)
DST = $(BUILD_PATH)$(OUT).pdf

default: build run

build: clean
	pandoc --toc --number-sections --chapters $(MD_FILES) -s -o $(DST)

run:
	evince $(DST) 2> /dev/null &

clean:
	rm -rf $(BUILD_PATH)*
