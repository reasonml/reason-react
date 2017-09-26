default: build

node_modules:
	npm install

build: node_modules
	npm run build

buildjs: node_modules
	npm run build:js

compare:
	diff -u src/test.exp.txt src/test.actual.txt
	rm -f src/test.actual.txt

testraw:
	./lib/bs/native/test.native >src/test.actual.txt
	$(MAKE) compare

test: build testraw


testjsraw:
	node --max-old-space-size=8192 lib/js/src/test.js >src/test.actual.txt
#	node --max-old-space-size=8192 --stack-size=65500 --stack-trace-limit=10000 --track-heap-objects lib/js/src/test.js >src/test.actual.txt
	$(MAKE) compare

testjs: buildjs testjsraw

clean:
	npm run clean
