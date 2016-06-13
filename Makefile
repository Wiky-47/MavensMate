REPORTER = html-cov
TESTS ?= $(shell find test -name '*.js')
COVERAGE_FILE = coverage.html

print-%: ; @echo $*=$($*)

test:
	@NODE_ENV=test HTTP_MAX_SOCKETS=5000 INDEX=$(INDEX) ./node_modules/.bin/mocha \
	--recursive \
	--check-leaks \
	$(TESTS)

coverage:
	@NODE_ENV=test HTTP_MAX_SOCKETS=5000 INDEX=$(INDEX) ./node_modules/.bin/mocha \
	--recursive \
	--require blanket \
	--reporter html-cov \
	$(TESTS) > test/coverage.html

coveralls:
	@NODE_ENV=test HTTP_MAX_SOCKETS=5000 INDEX=$(INDEX) YOURPACKAGE_COVERAGE=1 ./node_modules/.bin/mocha \
	--recursive \
	--require blanket \
	--reporter mocha-lcov-reporter \
	$(TESTS) | ./node_modules/coveralls/bin/coveralls.js


.PHONY: test
