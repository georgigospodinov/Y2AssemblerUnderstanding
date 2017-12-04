CC = gcc  # C Compiler to use

bin/bst-stack.s: src/bst-stack.c
	${CC} src/bst-stack.c -c -S -o bin/bst-stack.s

# .o files
bin/bst-sort.o: src/bst-sort.c src/bst.h
	${CC} src/bst-sort.c -c -o bin/bst-sort.o

bin/bst-commented.o: src/bst-commented.s src/bst.h
	${CC} src/bst-commented.s -c -o bin/bst-commented.o

bin/bst-stack.o: src/bst-stack.c src/bst.h
	${CC} src/bst-stack.c -c -o bin/bst-stack.o

bin/bst-o3-commented.o: src/bst-o3-commented.s src/bst.h
	${CC} src/bst-o3-commented.s -c -o bin/bst-o3-commented.o

# executables
bin/bst-sort-commented: bin/bst-commented.o bin/bst-sort.o
	${CC} bin/bst-commented.o bin/bst-sort.o -o bin/bst-sort-commented

bin/bst-sort-stack: bin/bst-stack.o bin/bst-sort.o src/bst.h
	${CC} bin/bst-stack.o bin/bst-sort.o -o bin/bst-sort-stack

bin/bst-sort-o3-commented: bin/bst-o3-commented.o bin/bst-sort.o
	${CC} bin/bst-o3-commented.o bin/bst-sort.o -o bin/bst-sort-o3-commented

# shortcuts
part1: bin/bst-sort-commented

part2: bin/bst-sort-stack

part3: bin/bst-sort-o3-commented

all: part1 part2 part3

# tests
test-part1: bin/bst-sort-commented
	./bin/bst-sort-commented tests/test1.in > testouts/test1.out
	diff testouts/test1.out tests/test1.out
	./bin/bst-sort-commented tests/test2.in > testouts/test2.out
	diff testouts/test2.out tests/test2.out
	./bin/bst-sort-commented tests/test3.in > testouts/test3.out
	diff testouts/test3.out tests/test3.out
	./bin/bst-sort-commented tests/test4.in > testouts/test4.out
	diff testouts/test4.out tests/test4.out

test-part2: bin/bst-sort-stack
	./bin/bst-sort-stack tests/mytest1.in > testouts/mytest1.out
	./bin/bst-sort-stack tests/mytest2.in > testouts/mytest2.out
	echo view "testouts/mytest<i>.out"

test-part3: bin/bst-sort-o3-commented
	./bin/bst-sort-o3-commented tests/test1.in > testouts/o3test1.out
	diff testouts/o3test1.out tests/test1.out
	./bin/bst-sort-o3-commented tests/test2.in > testouts/o3test2.out
	diff testouts/o3test2.out tests/test2.out
	./bin/bst-sort-o3-commented tests/test3.in > testouts/o3test3.out
	diff testouts/o3test3.out tests/test3.out
	./bin/bst-sort-o3-commented tests/test4.in > testouts/o3test4.out
	diff testouts/o3test4.out tests/test4.out

tests: test-part1 test-part2 test-part3

# cleans
clean-tests:
	rm -f testouts/*

clean: clean-tests
	rm -f bin/*


