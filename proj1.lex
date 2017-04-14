/**
 * Project 1 lex, lexicon for MIN-L
*/

%{
  #include <cstring>
  #include <iostream>
  #include "stdio.h"
  #include "string.h"
  #include "globals.h"
  int lineNo = 1;
  int charNo = 1;
  //maps go here
%}

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
endbody       printf("END_BODY");
{reserve}     printf("%s\n", reserve[yytext].c_str());charNo+=strlen(yytext);
{arithmetic}  printf("%s\n", arithmetic[yytext].c_str());charNo+=strlen(yytext);
{comparison}  printf("%s\n", comparison[yytext].c_str());charNo+=strlen(yytext);
{numberId}    printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", lineNo, charNo, yytext);exit(1);
{underId}     printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", lineNo, charNo, yytext);exit(1);
{id}          printf("IDENT %s\n", yytext);charNo+=strlen(yytext);
{number}      printf("NUMBER %s\n", yytext);charNo+=strlen(yytext);
{special}     printf("%s\n", special[yytext].c_str());charNo+=strlen(yytext);
\n            lineNo++;charNo=1;
.             printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", lineNo, charNo, yytext); exit(1);

%%


main (int argc, char** argv) {
  if (argc > 1) yyin = fopen(argv[1], "r");
  init_maps();
  yylex();
  return 0;
}


