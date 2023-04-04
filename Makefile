.DEFAULT_GOAL := test

.PHONY: test
test:
	rake

.PHONY: run
run:
	ruby ./app.rb
