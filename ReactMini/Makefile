default: build

build:
	cd src && make build

clean:
	cd src && make clean

test:
	cd src && make test

buildjs:
	npm install
	npm run build

cleanjs:
	npm run clean

testjs: buildjs
	node lib/js/src/test.js >src/test.actual.txt
	diff -u src/test.exp.txt src/test.actual.txt
	rm -f src/test.actual.txt
