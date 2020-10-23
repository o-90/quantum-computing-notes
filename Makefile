SHELL := /bin/bash

PREFIX := demiurge
IMAGE_NAME := texlive
TAG := latest

.PHONY: all
all: build-one build-two build-two-example build-three build-three-example \
	build-four build-four-example build-five build-five-example

.PHONY: build-image
build-image:
	docker build -t $(PREFIX)/$(IMAGE_NAME):$(TAG) -f Dockerfile .

.PHONY: run
run:
	docker run --rm -it \
		-v `pwd`:/app \
		-w /app \
		$(PREFIX)/$(IMAGE_NAME):$(TAG) \
		pdflatex -output-directory=$(DIR) $(TARGET)

.PHONY: build-one
build-one:
	@$(MAKE) TARGET=one/notes.tex DIR=one run

.PHONY: build-two
build-two:
	@$(MAKE) TARGET=two/notes.tex DIR=two run

.PHONY: build-two-example
build-two-example:
	@$(MAKE) TARGET=two/examples.tex DIR=two run

.PHONY: build-three
build-three:
	@$(MAKE) TARGET=three/notes.tex DIR=three run

.PHONY: build-three-example
build-three-example:
	@$(MAKE) TARGET=three/examples.tex DIR=three run

.PHONY: build-four
build-four:
	@$(MAKE) TARGET=four/notes.tex DIR=four run

.PHONY: build-four-example
build-four-example:
	@$(MAKE) TARGET=four/examples.tex DIR=four run

.PHONY: build-five
build-five:
	@$(MAKE) TARGET=five/notes.tex DIR=five run

.PHONY: build-five-example
build-five-example:
	@$(MAKE) TARGET=five/examples.tex DIR=five run

.PHONY: clean
clean:
	find . -name "*.aux" -exec rm -rf {} +
	find . -name "*.log" -exec rm -rf {} +
	find . -name "*.out" -exec rm -rf {} +
	find . -name "*.pdf" -exec rm -rf {} +
