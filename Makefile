.DEFAULT_GOAL := test

.PHONY: test
test:
	echo "Dir.glob('./test/*_test.rb').each { |file| require file }" | ruby

.PHONY: run
run:
	ruby ./app.rb
