/**
 * Project 1 lex, lexicon for MIN-L
*/

%{
  #include <cstring>
  #include <map>
  #include <iostream>
  #include "stdio.h"
  #include "string.h"
  #include "tok.h"
  int lineNo = 1;
  int charNo = 1;
  //maps go here
%}
	std::map<std::string, int> reserve;
	std::map<std::string, int> arithmetic;
	std::map<std::string, int> comparison;
	std::map<std::string, int> special;



reserve     function|beginparams|endparams|beginlocals|endlocals|beginbody|endbody|integer|array|of|if|then|endif|else|while|do|beginloop|endloop|continue|read|write|and|or|not|true|false|return
arithmetic    "-"|"+"|"*"|"/"|"%"
comparison    "=="|"<>"|"<"|">"|"<="|">="
id            [a-zA-Z][a-zA-Z0-9]*(_*[a-zA-Z0-9]+)*
number        [0-9]+
numberId      [0-9_]+{id}_*
underId       {id}_+
special       ";"|":"|","|"("|")"|"["|"]"|":="
%%
 
##.*	      ;
[ \t]         charNo++;
{reserve}     charNo+=strlen(yytext); return reserve[yytext];
{arithmetic}  charNo+=strlen(yytext); return arithmetic[yytext];
{comparison}  charNo+=strlen(yytext); return comparison[yytext];
{numberId}    printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", lineNo, charNo, yytext);exit(1);
{underId}     printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", lineNo, charNo, yytext);exit(1);
{id}          charNo+=strlen(yytext); yylval.id_val = new std::string(yytext); return IDENTIFIER;
{number}      charNo+=strlen(yytext); yylval.int_val = atoi(yytext); return NUMBER;
{special}     charNo+=strlen(yytext); return special[yytext];
\n            lineNo++;charNo=1;
.             printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", lineNo, charNo, yytext); exit(1);

%%





