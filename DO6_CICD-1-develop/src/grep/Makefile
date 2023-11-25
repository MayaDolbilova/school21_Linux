CC = gcc
CFLAGS =-std=c11 -Wall -Wextra -Werror

s21_grep:
	$(CC) $(CFLAGS) s21_grep.c -o s21_grep

clean:
	rm -rf s21_grep s21_grep.dSYM *.o *.out

rebuild: clean s21_grep

valgrind_check:
	sh ../../materials/build/run.sh

check: s21_grep
	cppcheck --enable=all --suppress=missingIncludeSystem . *.c *.h
	cp ../../materials/linters/CPPLINT.cfg ./
	python3 ./../../materials/linters/cpplint.py --extensions=c *.c *.h
	rm -f CPPLINT.cfg