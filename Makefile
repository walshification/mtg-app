VPATH = $(PATH)
BUNDLE = bundle exec

##### Development Help #####
help:
	cat README.md

start: env
	$(BUNDLE) rails server

##### Tests #####
test: env
	$(BUNDLE) rspec --exclude-pattern "spec/features/*_spec.rb"

# test-watch:

test_prepare:
	$(BUNDLE) rake db:test:prepare

js_te% : export PHANTOMJS_BIN=./node_modules/.bin/phantomjs

js-test: env
	$(BUNDLE) rake teaspoon

# js-test-watch: env
# 	./node_modules/karma/bin/karma start

features: env
	$(BUNDLE) rspec spec/features

scss_lint: env
	$(BUNDLE) rake scss_lint

all-the-tests: test features js-test

ci-test: all-the-tests

##### Dependencies #####
env:
	bundle

deps: env
	npm install && bower install

##### No Idea i.e. magic #####
.PHONY: rails db test features scss_lint all_the_tests docs clone_db js_test deps js_test_watch env help start redis sidekiq
