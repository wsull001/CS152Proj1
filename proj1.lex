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
  std::unordered_map<std::string, std::string> airthmetic();
  std::unordered_map<std::string, std::string> comparison();
  std::unordered_map<std::string, std::string> special();
%}

//patterns go here

%%  



%%


main (int argc, char** argv) {
  if (argc > 1) yyin = fopen(argv[1], "r");
  init_maps();
  yylex();
  return 0;
}

void init_maps(){
  //reserve map init
  reserve.insert("function", "FUNCTION");
  reserve.insert("beginparams", "BEGIN_PARAMS");
  reserve.insert("END_PARAMS", "END_PARAMS");
  reserve.insert("beginlocals", "BEGIN_LOCALS");
  reserve.insert("endlocals", "END_LOCALS");
  reserve.insert("beginbody", "BEGIN_BODY");
  reserve.insert("endbody", "END_BODY");
  reserve.insert("integer", "INTEGER");
  reserve.insert("array", "ARRAY");
  reserve.insert("of", "OF");
  reserve.insert("if", "IF");
  reserve.insert("then", "THEN");
  reserve.insert("endif", "ENDIF");
  reserve.insert("else", "ELSE");
  reserve.insert("while", "WHILE");
  reserve.insert("do", "DO");
  reserve.insert("beginloop", "BEGINLOOP");
  reserve.insert("endloop", "ENDLOOP");
  reserve.insert("continue", "CONTINUE");
  reserve.insert("read", "READ");
  reserve.insert("write", "WRITE");
  reserve.insert("and", "AND");
  reserve.insert("or", "OR");
  reserve.insert("not", "NOT");
  reserve.insert("true", "TRUE");
  reserve.insert("false", "FALSE");
  reserve.insert("return", "RETURN");
  //arithmetic map init
  arithmetic.insert("-","SUB");
  arithmetic.insert("+","ADD");
  arithmetic.insert("*","MULT");
  arithmetic.insert("/","DIV");
  arithmetic.insert("%","MOD");
  //comparison map init
  comparison.insert("==","EQ");
  comparison.insert("<>","NEQ");
  comparison.insert("<","LT");
  comparison.insert(">","GT");
  comparison.insert("<=","LTE");
  comparison.insert(">=","GTE");
  //special map init
  special.insert(";","SEMICOLON");
  special.insert(":","COLON");
  special.insert(",","COMMA");
  special.insert("(","L_PAREN");
  special.insert(")","R_PAREN");
  special.insert("[","L_SQUARE_BRACKET");
  special.insert("]","R_SQUARE_BRACKET");
  special.insert(":=","ASSIGN");
}
