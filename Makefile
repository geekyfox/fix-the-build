MARKDOWN_FILES := $(sort $(wildcard chapters/*.md))
HTML_CHAPTERS  := $(patsubst chapters/%.md,build/chapter_%.html,$(MARKDOWN_FILES))
HTML_FILES     := tools/header.html build/toc.html $(HTML_CHAPTERS) tools/footer.html
MARKDOWN_FMTED := $(patsubst chapters/%.md,build/%.md,$(MARKDOWN_FILES)) build/README.md

release/index.html: $(HTML_FILES)
	@mkdir -p release
	cat $(HTML_FILES) > $@

build/toc.html: $(MARKDOWN_FILES) tools/toc.awk
	@mkdir -p build
	awk -f tools/toc.awk $(MARKDOWN_FILES) > $@

build/chapter_%.html: chapters/%.md tools/chapter.awk
	@mkdir -p build
	awk -f tools/chapter.awk $< > $@

.PHONY: fmt
fmt: $(MARKDOWN_FMTED)
	mv build/README.md .
	mv build/*.md chapters

build/README.md: README.md tools/fmt.awk
	@mkdir -p build
	awk -f tools/fmt.awk $< > $@

build/%.md: chapters/%.md tools/fmt.awk
	@mkdir -p build
	awk -f tools/fmt.awk $< > $@

.PHONY: clean
clean:
	rm -f build/*
	rm -f index.html

