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

//patterns go here

%%  



%%


main (int argc, char** argv) {
  if (argc > 1) yyin = fopen(argv[1], "r");
  yylex();
  return 0;
} 
