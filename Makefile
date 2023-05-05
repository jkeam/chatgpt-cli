.DEFAULT_GOAL := test

.PHONY: test
test:
	rake

.PHONY: run
run:
	bundle exec ruby ./app.rb
