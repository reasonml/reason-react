default: build

node_modules:
	npm install

build: node_modules
	npm run build

buildjs: node_modules
	npm run build:js

test: build
	./lib/bs/native/test.native >src/test.actual.txt
	diff -u src/test.exp.txt src/test.actual.txt
	rm -f src/test.actual.txt

testjs: buildjs
	node lib/js/src/test.js >src/test.actual.txt
	diff -u src/test.exp.txt src/test.actual.txt
	rm -f src/test.actual.txt

clean:
	npm run clean
