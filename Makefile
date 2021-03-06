BUNDLE = bundle exec
RAKE = $(BUNDLE) rake
RSPEC = $(BUNDLE) rspec

##### Development Help #####
help:
	cat README.md

start: env
	$(BUNDLE) rails server

##### Tests #####
test: env
	$(RSPEC) --exclude-pattern "spec/features/*_spec.rb"

test-watch: env
	$(BUNDLE) guard

js-test: deps
	$(RAKE) teaspoon

features: deps
	$(RSPEC) spec/features

lint: env
	$(BUNDLE) rubocop

all-the-tests: lint
	export PHANTOMJS_BIN=./node_modules/.bin/phantomjs && $(RSPEC) && $(RAKE) teaspoon

##### Dependencies #####
env:
	bundle

deps: env
	npm install

clean:
	rm -rf node_modules vendor/assets/bower_components

.PHONY: env test features all-the-tests js-test deps help start test-watch lint
