/* main.cc */

#include "heading.h"
#include "tok.h"
#include <map>

// prototype of bison-generated parser function
int yyparse();

extern std::map<std::string, int> reserve;
extern std::map<std::string, int> arithmetic;
extern std::map<std::string, int> comparison;
extern std::map<std::string, int> special;

void init_maps();

int main(int argc, char **argv)
{
  init_maps();
  if ((argc > 1) && (freopen(argv[1], "r", stdin) == NULL))
  {
    cerr << argv[0] << ": File " << argv[1] << " cannot be opened.\n";
    exit( 1 );
  }
  
  yyparse();

  return 0;
}


void init_maps(){
  //reserve map init
  reserve.insert(std::make_pair<std::string, int>("function", FUNCTION));
  reserve.insert(std::make_pair<std::string, int>("beginparams", BEGIN_PARAMS));
  reserve.insert(std::make_pair<std::string, int>("endparams", END_PARAMS));
  reserve.insert(std::make_pair<std::string, int>("beginlocals", BEGIN_LOCALS));
  reserve.insert(std::make_pair<std::string, int>("endlocals", END_LOCALS));
  reserve.insert(std::make_pair<std::string, int>("beginbody", BEGIN_BODY));
  reserve.insert(std::make_pair<std::string, int>("endbody", END_BODY));
  reserve.insert(std::make_pair<std::string, int>("integer", INTEGER));
  reserve.insert(std::make_pair<std::string, int>("array", ARRAY));
  reserve.insert(std::make_pair<std::string, int>("of", OF));
  reserve.insert(std::make_pair<std::string, int>("if", IF));
  reserve.insert(std::make_pair<std::string, int>("then", THEN));
  reserve.insert(std::make_pair<std::string, int>("endif", ENDIF));
  reserve.insert(std::make_pair<std::string, int>("else", ELSE));
  reserve.insert(std::make_pair<std::string, int>("while", WHILE));
  reserve.insert(std::make_pair<std::string, int>("do", DO));
  reserve.insert(std::make_pair<std::string, int>("beginloop", BEGINLOOP));
  reserve.insert(std::make_pair<std::string, int>("endloop", ENDLOOP));
  reserve.insert(std::make_pair<std::string, int>("continue", CONTINUE));
  reserve.insert(std::make_pair<std::string, int>("read", READ));
  reserve.insert(std::make_pair<std::string, int>("write", WRITE));
  reserve.insert(std::make_pair<std::string, int>("and", AND));
  reserve.insert(std::make_pair<std::string, int>("or", OR));
  reserve.insert(std::make_pair<std::string, int>("not", NOT));
  reserve.insert(std::make_pair<std::string, int>("true", TRUE));
  reserve.insert(std::make_pair<std::string, int>("false", FALSE));
  reserve.insert(std::make_pair<std::string, int>("return", RETURN));
  //arithmetic map init
  arithmetic.insert(std::make_pair<std::string, int>("-",SUB));
  arithmetic.insert(std::make_pair<std::string, int>("+",ADD);
  arithmetic.insert(std::make_pair<std::string, int>("*",MULT));
  arithmetic.insert(std::make_pair<std::string, int>("/",DIV));
  arithmetic.insert(std::make_pair<std::string, int>("%",MOD));
  //comparison map init
  comparison.insert(std::make_pair<std::string, int>("==",EQ));
  comparison.insert(std::make_pair<std::string, int>("<>",NEQ));
  comparison.insert(std::make_pair<std::string, int>("<",LT));
  comparison.insert(std::make_pair<std::string, int>(">",GT));
  comparison.insert(std::make_pair<std::string, int>("<=",LTE));
  comparison.insert(std::make_pair<std::string, int>(">=",GTE));
  //special map init
  special.insert(std::make_pair<std::string, int>(";",SEMICOLON));
  special.insert(std::make_pair<std::string, int>(":",COLON));
  special.insert(std::make_pair<std::string, int>(",",COMMA));
  special.insert(std::make_pair<std::string, int>("(",L_PAREN));
  special.insert(std::make_pair<std::string, int>(")",R_PAREN));
  special.insert(std::make_pair<std::string, int>("[",L_SQUARE_BRACKET));
  special.insert(std::make_pair<std::string, int>("]",R_SQUARE_BRACKET));
}
