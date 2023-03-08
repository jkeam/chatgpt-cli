.PHONY: default
default:
	echo "Dir.glob('./test/*_test.rb').each { |file| require file }" | ruby

.PHONY: run
run: 
	ruby ./app.rb
