/**
 * Project 1 lex, lexicon for MIN-L
*/

%{
  #include <unordered_map>
  #include <cstring>
  #include <string>
  #include "stdio.h"
  int lineNo = 0;
  int charNo = 0;
  //maps go here
  std::unordered_map<std::string, std::string> reserve();
%}

reserve     function|beginparams|endparams|beginlocals|endlocals|beginbody|endbody|integer|array|of|if|then|endif|else|while|do|beginloop|endloop|continue|read|write|and|or|not|true|false|return
arithmetic "-"|"+"|"*"|"/"|"%"
comparison  "=="|"<>"|"<"|">"|"<="|">="
id  [a-zA-Z][a-zA-Z"_"0-9]*[^"_"]
special ";"|":"|","|"("|")"|"["|"]"|":="




%%  
{reserve} printf("RESERVED WORD\n");
{arithmetic} printf("ARITH\n");
{comparison} printf("COMPARE\n");
{id} printf("ID\n");
{special} printf("SPECIAL");
.         printf("ERROR");exit(1);


%%


main (int argc, char** argv) {
  if (argc > 1) yyin = fopen(argv[1], "r");
  yylex();
  return 0;
} 
