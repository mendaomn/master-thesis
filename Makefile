SRC_PATH = ./src

THESIS_PATH = ./build/
THESIS_TITLE = thesis

DST = $(THESIS_PATH)$(THESIS_TITLE).pdf
MD_FILES := $(shell find $(SRC_PATH) -type f -name "*.md" | grep -v "README" | sort)

default: run

build: clean
	pandoc $(MD_FILES) -s -o $(DST)

run: build
	evince $(DST) > /dev/null &

clean:
	rm -rf $(THESIS_PATH)*
