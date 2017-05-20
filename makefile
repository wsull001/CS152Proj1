# Makefile

OBJS	= bison.o lex.o main.o

CC	= g++
CFLAGS	= -std=c++11 -g -Wall -ansi -pedantic

proj2:		$(OBJS)
		$(CC) $(CFLAGS) $(OBJS) -o proj2 -lfl

lex.o:		lex.c
		$(CC) $(CFLAGS) -c lex.c -o lex.o

lex.c:		proj2.lex 
		flex proj2.lex
		cp lex.yy.c lex.c

bison.o:	bison.c
		$(CC) $(CFLAGS) -c bison.c -o bison.o

bison.c:	proj2.y functions.h
		
		bison -d -v proj2.y
		cp proj2.tab.c bison.c
		cmp -s proj2.tab.h tok.h || cp proj2.tab.h tok.h

main.o:		main.cc
		$(CC) $(CFLAGS) -c main.cc -o main.o

lex.o yac.o main.o  : functions.h
lex.o yac.o main.o	: heading.h
lex.o main.o		: tok.h

clean:
	rm -f *.o *~ lex.c lex.yy.c bison.c tok.h proj2.tab.c proj2.tab.h proj2.output proj2

