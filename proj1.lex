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




%%  
{reserve} printf("RESERVED WORD");
.         ;


%%


main (int argc, char** argv) {
  if (argc > 1) yyin = fopen(argv[1], "r");
  yylex();
  return 0;
} 
