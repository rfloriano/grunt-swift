PATH := ./node_modules/.bin:${PATH}

.PHONY : setup clean build test dist publish

setup:
	@npm install

clean:
	rm -rf lib/ test/*.js

build:
	coffee -o tasks/ -c src/grunt-swift.coffee
	coffee -o lib/ -c src/swift.coffee

test:
	nodeunit test/refix.js

dist: clean setup build test

publish: dist
	npm publish --registry https://artifactory.globoi.com/artifactory/api/npm/npm-local .
