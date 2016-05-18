BUNDLE = bundle exec
RAKE = $(BUNDLE) rake
RSPEC = $(BUNDLE) rspec

##### Development Help #####
help:
	cat README.md

start: env
	$(BUNDLE) rails server

##### Node Path Export #####
ci-% : export PHANTOMJS_BIN=./node_modules/.bin/phantomjs

##### Tests #####
test: env
	$(RSPEC) --exclude-pattern "spec/features/*_spec.rb"

# test-watch:

# test_prepare:
# 	$(BUNDLE) rake db:test:prepare

# js_te% : export PHANTOMJS_BIN=./node_modules/.bin/phantomjs

js-test: env
	$(RAKE) teaspoon

# js-test-watch: env
# 	./node_modules/karma/bin/karma start

features: env
	$(RSPEC) spec/features

all-the-tests:
	$(RSPEC) && $(RAKE) teaspoon

ci-test: all-the-tests

##### Dependencies #####
env:
	bundle

deps: env
	npm install && bower install

##### No Idea i.e. magic #####
.PHONY: env test features all-the-tests js-test deps help start
