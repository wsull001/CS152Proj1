all: lex.yy.c
	g++ -std=c++11 lex.yy.c -lfl
lex.yy.c: proj1.lex
	flex proj1.lex
