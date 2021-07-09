main:
	make c 
	make fortran 
	make ada

c: kmp.c
	gcc -g -Wall -o kmp-c kmp.c

fortran: kmp.f95
	gfortran -o kmp-fortran kmp.f95

ada: kmp.adb
	gnatmake -o kmp-ada kmp.adb

clean:
	rm kmp-ada kmp.ali kmp.o kmp-fortran kmp-c test.txt