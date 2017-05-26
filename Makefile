# Makefile

OBJS      =  yac.o  lex.o  main.o  
#nodes.o
SFLS      =  yac.c  lex.c  main.cc 
#nodes.cc

CC        =  g++ 
#CC        =  gcc
CXXFLAGS  =  -std=c++11 -w 
CFLAGS    =  -std=c++11 -w 

# CFLAGS    =  -g -I/usr/local/include/sgi-stl -Wall -DYYDEBUG=1
# CFLAGS    =  -g -Wall -DYYDEBUG=1
# CXXFLAGS  =  -g -I/usr/local/include/sgi-stl -pedantic # -Wall -W -Werror
# CXXFLAGS  =  -g -pedantic # -Wall -W -Werror
# CXXFLAGS  =  -std=c++11 -w -v
# CFLAGS    =  -std=c++11 -w -v


compile:	$(OBJS)
		$(CC) $(CFLAGS) $(OBJS)  -o compile 
#		$(CC) $(CFLAGS) $(OBJS)  -o compile -lfl 

lex.o yac.o main.o /*nodes.o*/	: heading.H 
lex.o main.o /*nodes.o*/	: tok.h
# yac.o main.o lex.o nodes.o : nodes.cc 

lex.c:		lex.src 
		flex lex.src
		-cmp -s lex.yy.c lex.c || cp lex.yy.c lex.c

yac.c:		source.y
		bison -d -v source.y
		-cmp -s source.tab.c yac.c || cp source.tab.c yac.c
	 	-cmp -s source.tab.h tok.h || cp source.tab.h tok.h

clean:
		rm *.o lex.c lex.yy.c yac.c source.tab.c\
		source.output source.tab.h tok.h printout.ps core

print:		
		a2ps --line-numbers=1 -M letter /*README*/ Makefile heading.H\
                lex.src main.cc source.y nodes.h /*nodes.cc*/ -o printout.ps

size:		
		cat lex.src source.y nodes.h /*nodes.cc*/ main.cc heading.H | wc

# checkin:
# 		ci README Makefile lex.src source.y nodes.h nodes.cc main.cc\
# 		heading.H lib.h

# checkout:
# 		co -l  README Makefile lex.src source.y nodes.h nodes.cc\
# 		main.cc heading.H lib.h

test:		
		./testscript

