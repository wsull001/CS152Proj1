/* Mini Calculator */
/* calc.y */

%{
#include "heading.h"
#include <cstring>
int yyerror(char *s);
int yylex(void);

//the following are UBUNTU/LINUX ONLY terminal color codes.
#define RESET   "\033[0m"
#define BLACK   "\033[30m"      /* Black */
#define RED     "\033[31m"      /* Red */
#define GREEN   "\033[32m"      /* Green */
#define YELLOW  "\033[33m"      /* Yellow */
#define BLUE    "\033[34m"      /* Blue */
#define MAGENTA "\033[35m"      /* Magenta */
#define CYAN    "\033[36m"      /* Cyan */
#define WHITE   "\033[37m"      /* White */
#define BOLDBLACK   "\033[1m\033[30m"      /* Bold Black */
#define BOLDRED     "\033[1m\033[31m"      /* Bold Red */
#define BOLDGREEN   "\033[1m\033[32m"      /* Bold Green */
#define BOLDYELLOW  "\033[1m\033[33m"      /* Bold Yellow */
#define BOLDBLUE    "\033[1m\033[34m"      /* Bold Blue */
#define BOLDMAGENTA "\033[1m\033[35m"      /* Bold Magenta */
#define BOLDCYAN    "\033[1m\033[36m"      /* Bold Cyan */
#define BOLDWHITE   "\033[1m\033[37m"      /* Bold White */
%}

%union{
  int		junk;
  int		int_val;
  std::string*	str_val;
  std::string*	id_val;
}

%start	Program 

//non terminals
%type	<str_val>	Function
%type	<str_val>	Statement_blk
%type 	<str_val>	Statement
%type	<str_val>	Else_blk
%type	<str_val>	Bool_exp
%type	<str_val>	Or
%type	<str_val>	Relation_and_exp
%type	<str_val>	Not
%type	<str_val>	Comp
%type	<str_val>	Expression
%type	<str_val>	Multiplicative_exp_blk
%type	<str_val>	Multiplicative_exp_add
%type	<str_val>	Multiplicative_exp_sub
%type	<str_val>	Multiplicative_exp
%type	<str_val>	Term_blk
%type	<str_val>	Var
%type	<str_val>	Term
%type	<str_val>	Expression_blk
%type	<str_val>	Identifier_blk
// end non terminals

%nonassoc	<junk>		FUNCTION
%token		<str_val>	INTEGER_LITERAL
%nonassoc	<junk>		BEGIN_PARAMS
%nonassoc	<junk>		END_PARAMS
%nonassoc	<junk>		BEGIN_LOCALS
%nonassoc	<junk>		END_LOCALS
%nonassoc	<junk>		BEGIN_BODY
%nonassoc	<junk>		END_BODY
%token		<str_val>	INTEGER
%token		<str_val>	ARRAY
%token		<junk>		OF
%nonassoc	<junk>		IF
%token		<junk>	 	THEN
%token		<junk>		ENDIF
%nonassoc	<junk>		ELSE
%nonassoc	<junk>		WHILE
%token		<junk>		DO
%token		<junk>		BEGINLOOP
%token		<junk>		ENDLOOP
%token		<junk>		CONTINUE
%token		<junk>		READ
%token		<junk>		WRITE
%token		<junk>		TRUE
%token		<junk>		FALSE
%token		<junk>		RETURN
%token		<junk>		SEMICOLON
%token		<junk>		COLON
%token		<junk>		COMMA
%token		<id_val>	IDENTIFIER
%token		<str_val>	NUMBER

%right		<junk>		ASSIGN
%left		<junk>		OR
%left		<junk>		AND
%right		<junk>		NOT
%left		<junk>		NEQ
%left		<junk>		EQ
%left		<junk>		GTE
%left		<junk>		GT
%left		<junk>		LTE
%left		<junk>		LT
%left		<junk>		SUB
%left		<junk>		ADD
%left		<junk>		MOD
%left		<junk>		DIV
%left		<junk>		MULT
%left		<junk>		L_PAREN
%left		<junk>		R_PAREN
%left		<junk>		L_SQUARE_BRACKET
%left		<junk>		R_SQUARE_BRACKET

%%

Program:	Function Program { cout << "Program -> Function Program" << endl;}
		| { $$ = new std::string(); }
		;

Function:	FUNCTION IDENTIFIER SEMICOLON BEGIN_PARAMS Declaration_blk END_PARAMS BEGIN_LOCALS
		 Declaration_blk END_LOCALS BEGIN_BODY Statement_blk END_BODY { cout << "Function - > FUNCTION " << *((std::string*)$2) << " SEMICOLON BEGIN_PARAMS Declaration_blk END_PARAMS BEGIN_LOCALS Declaration END_LOCALS BEGIN_BODY Statement_blk END_BODY" << endl; }
		;

Declaration_blk:	Declaration SEMICOLON Declaration_blk { cout << "Declaration_blk -> Declaration SEMICOLON Declaration_blk" << endl; }
			| { $$ = new std::string(); }
			;

Declaration:	IDENTIFIER Identifier_blk COLON Array_declaration INTEGER { cout << "Declaration -> " << *((std::string*)$1) << *((std::string)$2) "COLON Array_declaration INTEGER" << endl; }
		;

Identifier_blk: COMMA IDENTIFIER Identifier_blk { $$ = new std::string(*((std::string*)$2) + ',' + *((std::string*)$3)); }
		| { $$ = new std::string(); }
		;

Array_declaration:	ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF { cout << "Array_declaration -> ARRAY L_SQUARE_BRACKET " << $3 << "R_SQUARE_BRACKET OF" << endl; }
			| { $$ = new std::string(); }
			;

Statement_blk:	Statement SEMICOLON Statement_blk { cout << "Statement_blk -> Statement SEMICOLON Statement_blk" << endl; }
		| { $$ = new std::string(); }
		;

Statement:	Var ASSIGN Expression {cout << "Statement -> Var ASSIGN Expression" << endl;}
		| IF Bool_exp THEN Statement SEMICOLON Statement_blk Else_blk ENDIF{cout << "Statement -> IF Bool_exp THEN Statement SEMICOLON Statement_blk Else_blk ENDIF" << endl;}
		| WHILE Bool_exp BEGINLOOP Statement SEMICOLON Statement_blk ENDLOOP {cout << "Statement -> WHILE Bool_exp BEGINLOOP Statement SEMICOLON Statement_blk ENDLOOP" << endl;}
		| DO BEGINLOOP Statement SEMICOLON Statement_blk ENDLOOP WHILE Bool_exp {cout << "Statement -> WHILE Bool_exp BEGINLOOP Statement SEMICOLON Statement_blk ENDLOOP" << endl;}
		| READ Var Var_blk {cout << "Statement -> READ Var Var_blk" << endl;}
		| WRITE Var Var_blk {cout << "Statement -> WRITE Var Var_blk" << endl;}
		| CONTINUE {cout << "Statement -> CONTINUE" << endl;}
		| RETURN Expression {cout << "Statement -> RETURN Expression" << endl;}
		;

Else_blk:	ELSE Statement SEMICOLON Statement_blk {cout << "Else_blk -> ELSE Statement SEMICOLON Statement_blk" << endl;}
		| { $$ = new std::string(); }
		;

Bool_exp:	Relation_and_exp Or {cout << "Bool_exp -> Relation_and_exp Or" << endl;}
		;

Or:		OR Relation_and_exp Or {cout << "OR -> OR Relation_and_exp Or" << endl;}
		| { $$ = new std::string(); }
		;

Relation_and_exp:	Relation_exp And {cout << "Relation_and_exp -> Relation_exp And" << endl;}
			;

And:		AND Relation_exp And {cout << "And -> AND Relation_exp And" << endl;}
		| { $$ = new std::string(); }
		;

Relation_exp:	Not Expression Comp Expression {cout << "Relation_exp -> Not Expression Comp Expression" << endl;}
		| Not TRUE {cout << "Relation_exp -> Not TRUE" << endl;}
		| Not FALSE {cout << "Relation_exp -> Not FALSE" << endl;}
		| Not L_PAREN Bool_exp R_PAREN {cout << "Relation_exp -> Not L_PAREN Bool_exp R_PAREN" << endl;}
		;

Not:		NOT {cout << "Not -> NOT" << endl;}
		| { $$ = new std::string(); }
		;

Comp:		EQ {cout << "Comp -> EQ" << endl;}
		| LT {cout << "Comp -> LT" << endl;}
		| GT {cout << "Comp -> GT" << endl;}
		| NEQ {cout << "Comp -> NEQ" << endl;}
		| LTE {cout << "Comp -> LTE" << endl;}
		| GTE {cout << "Comp -> GTE" << endl;}
		;

Expression:	Multiplicative_exp Multiplicative_exp_blk {cout << "Expression -> Multiplicative_exp Multiplicative_exp_blk" << endl;}
		;

Multiplicative_exp_blk:	Multiplicative_exp_add Multiplicative_exp_blk {cout << "Multiplicative_exp_blk -> Multiplicative_exp_add Multiplicative_exp_blk" << endl;}
			| Multiplicative_exp_sub Multiplicative_exp_blk {cout << "Multiplicative_exp_blk -> Multiplicative_exp_sub Multiplicative_exp_blk" << endl;}
			| { $$ = new std::string(); }
			;

Multiplicative_exp_add:	ADD Multiplicative_exp { cout << "Multiplicative_exp_add -> ADD Multiplicative_exp" << endl; }
			;

Multiplicative_exp_sub:	SUB Multiplicative_exp { cout << "Multiplicative_exp_sub -> SUB Multiplicative_exp" << endl; }
			;

Multiplicative_exp:	Term Term_blk { cout << "Multiplicative_exp -> Term Term_blk" << endl;}
			;

Term_blk:	MULT Term Term_blk {cout << "Term_blk -> MULT Term Term_blk" << endl;}
		| DIV Term Term_blk {cout << "Term_blk -> DIV Term Term_blk" << endl;}
		| MOD Term Term_blk {cout << "Term_blk -> MOD Term Term_blk" << endl;}
		| { $$ = new std::string(); }
		;

Var:		IDENTIFIER { cout << "Var -> " << *((std::string*)$1) << endl;}
		| IDENTIFIER L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {cout << "Var ->" << *((std::string*)$1) << "L_SQUARE_BRACKET Expression R_SQUARE_BRACKET" << endl;}
		;

Var_blk:	COMMA Var Var_blk {cout << "Var_blk -> COMMA VAR Var_blk" << endl;}
		| { $$ = new std::string(); }
		;

Term:		SUB Var { cout << "SUB Var" << endl;}
		| Var {cout << "Term -> Var" << endl;}
		| SUB NUMBER {cout << "Term -> SUB " << $2 << endl;}
		| NUMBER {cout << "Term -> " << $1 << endl;}
		| SUB L_PAREN Expression R_PAREN { cout << "Term -> SUB L_PAREN Expression R_PAREN" << endl; }
		| L_PAREN Expression R_PAREN { cout << "Term -> SUB L_PAREN Expression R_PAREN" << endl; }
		| IDENTIFIER  L_PAREN Expression Expression_blk R_PAREN {cout << "Term -> " << *((std::string*)$1) << " L_PAREN Expression Expression_blk R_PAREN" << endl;}
		| IDENTIFIER L_PAREN R_PAREN {cout << "Term -> " << *((std::string*)$1) << " L_PAREN R_PAREN" << endl;}
		;

Expression_blk: COMMA Expression Expression_blk { cout << "Expression_blk -> COMMA Expression Expressin_blk" << endl;}
		| { $$ = new std::string(); }
		;



%%

int yyerror(string s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c
  extern int charNo;
  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << " at character " << charNo - strlen(yytext) << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}


