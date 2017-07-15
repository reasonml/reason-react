default: build

build:
	rebuild -r -cflags -g -lflags -g -cflags -bin-annot -cflags -annot test.byte

clean:
	rm -rf _build test.byte

test: build
	./test.byte >test.actual.txt
	diff -u test.exp.txt test.actual.txt
	rm -f test.actual.txt
