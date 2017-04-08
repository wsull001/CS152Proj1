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
%}

	std::unordered_map<std::string, std::string> reserve;
	std::unordered_map<std::string, std::string> arithmetic;
	std::unordered_map<std::string, std::string> comparison;
	std::unordered_map<std::string, std::string> special;


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

void init_maps();

main (int argc, char** argv) {
  if (argc > 1) yyin = fopen(argv[1], "r");
  init_maps();
  yylex();
  return 0;
}

void init_maps(){
  //reserve map init
  reserve.insert(std::make_pair<std::string, std::string>("function", "FUNCTION"));
  reserve.insert(std::make_pair<std::string, std::string>("beginparams", "BEGIN_PARAMS"));
  reserve.insert(std::make_pair<std::string, std::string>("END_PARAMS", "END_PARAMS"));
  reserve.insert(std::make_pair<std::string, std::string>("beginlocals", "BEGIN_LOCALS"));
  reserve.insert(std::make_pair<std::string, std::string>("endlocals", "END_LOCALS"));
  reserve.insert(std::make_pair<std::string, std::string>("beginbody", "BEGIN_BODY"));
  reserve.insert(std::make_pair<std::string, std::string>("endbody", "END_BODY"));
  reserve.insert(std::make_pair<std::string, std::string>("integer", "INTEGER"));
  reserve.insert(std::make_pair<std::string, std::string>("array", "ARRAY"));
  reserve.insert(std::make_pair<std::string, std::string>("of", "OF"));
  reserve.insert(std::make_pair<std::string, std::string>("if", "IF"));
  reserve.insert(std::make_pair<std::string, std::string>("then", "THEN"));
  reserve.insert(std::make_pair<std::string, std::string>("endif", "ENDIF"));
  reserve.insert(std::make_pair<std::string, std::string>("else", "ELSE"));
  reserve.insert(std::make_pair<std::string, std::string>("while", "WHILE"));
  reserve.insert(std::make_pair<std::string, std::string>("do", "DO"));
  reserve.insert(std::make_pair<std::string, std::string>("beginloop", "BEGINLOOP"));
  reserve.insert(std::make_pair<std::string, std::string>("endloop", "ENDLOOP"));
  reserve.insert(std::make_pair<std::string, std::string>("continue", "CONTINUE"));
  reserve.insert(std::make_pair<std::string, std::string>("read", "READ"));
  reserve.insert(std::make_pair<std::string, std::string>("write", "WRITE"));
  reserve.insert(std::make_pair<std::string, std::string>("and", "AND"));
  reserve.insert(std::make_pair<std::string, std::string>("or", "OR"));
  reserve.insert(std::make_pair<std::string, std::string>("not", "NOT"));
  reserve.insert(std::make_pair<std::string, std::string>("true", "TRUE"));
  reserve.insert(std::make_pair<std::string, std::string>("false", "FALSE"));
  reserve.insert(std::make_pair<std::string, std::string>("return", "RETURN"));
  //arithmetic map init
  arithmetic.insert(std::make_pair<std::string, std::string>("-","SUB"));
  arithmetic.insert(std::make_pair<std::string, std::string>("+","ADD"));
  arithmetic.insert(std::make_pair<std::string, std::string>("*","MULT"));
  arithmetic.insert(std::make_pair<std::string, std::string>("/","DIV"));
  arithmetic.insert(std::make_pair<std::string, std::string>("%","MOD"));
  //comparison map init
  comparison.insert(std::make_pair<std::string, std::string>("==","EQ"));
  comparison.insert(std::make_pair<std::string, std::string>("<>","NEQ"));
  comparison.insert(std::make_pair<std::string, std::string>("<","LT"));
  comparison.insert(std::make_pair<std::string, std::string>(">","GT"));
  comparison.insert(std::make_pair<std::string, std::string>("<=","LTE"));
  comparison.insert(std::make_pair<std::string, std::string>(">=","GTE"));
  //special map init
  special.insert(std::make_pair<std::string, std::string>(";","SEMICOLON"));
  special.insert(std::make_pair<std::string, std::string>(":","COLON"));
  special.insert(std::make_pair<std::string, std::string>(",","COMMA"));
  special.insert(std::make_pair<std::string, std::string>("(","L_PAREN"));
  special.insert(std::make_pair<std::string, std::string>(")","R_PAREN"));
  special.insert(std::make_pair<std::string, std::string>("[","L_SQUARE_BRACKET"));
  special.insert(std::make_pair<std::string, std::string>("]","R_SQUARE_BRACKET"));
  special.insert(std::make_pair<std::string, std::string>(":=","ASSIGN"));
}
