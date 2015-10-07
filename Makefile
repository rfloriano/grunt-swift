PATH := ./node_modules/.bin:${PATH}

.PHONY : init clean build test dist publish

init:
	npm install

clean:
	rm -rf lib/ test/*.js

build:
	coffee -o tasks/ -c src/

test:
	nodeunit test/refix.js

dist: clean init build test

publish: dist
	npm publish --registry https://artifactory.globoi.com/artifactory/api/npm/npm-local .
