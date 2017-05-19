/* Mini Calculator */
/* calc.y */

%{
#include "heading.h"
#include <cstring>
#include <string>
#include <stdio.h>
#include <stdlib.h>
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
%type	<str_val>	Array_declaration
%type	<str_val>	Declaration_blk
%type	<str_val>	Program
%type	<str_val>	Var_blk
%type	<str_val>	And
%type	<str_val>	Declaration
	
// end non terminals

%nonassoc	<str_val>		FUNCTION
%token		<str_val>	INTEGER_LITERAL
%nonassoc	<str_val>		BEGIN_PARAMS
%nonassoc	<str_val>		END_PARAMS
%nonassoc	<str_val>		BEGIN_LOCALS
%nonassoc	<str_val>		END_LOCALS
%nonassoc	<str_val>		BEGIN_BODY
%nonassoc	<str_val>		END_BODY
%token		<str_val>	INTEGER
%token		<str_val>	ARRAY
%token		<str_val>		OF
%nonassoc	<str_val>		IF
%token		<str_val>	 	THEN
%token		<str_val>		ENDIF
%nonassoc	<str_val>		ELSE
%nonassoc	<str_val>		WHILE
%token		<str_val>		DO
%token		<str_val>		BEGINLOOP
%token		<str_val>		ENDLOOP
%token		<str_val>		CONTINUE
%token		<str_val>		READ
%token		<str_val>		WRITE
%token		<str_val>		TRUE
%token		<str_val>		FALSE
%token		<str_val>		RETURN
%token		<str_val>		SEMICOLON
%token		<str_val>		COLON
%token		<str_val>		COMMA
%token		<id_val>	IDENTIFIER
%token		<str_val>	NUMBER

%right		<str_val>		ASSIGN
%left		<str_val>		OR
%left		<str_val>		AND
%right		<str_val>		NOT
%left		<str_val>		NEQ
%left		<str_val>		EQ
%left		<str_val>		GTE
%left		<str_val>		GT
%left		<str_val>		LTE
%left		<str_val>		LT
%left		<str_val>		SUB
%left		<str_val>		ADD
%left		<str_val>		MOD
%left		<str_val>		DIV
%left		<str_val>		MULT
%left		<str_val>		L_PAREN
%left		<str_val>		R_PAREN
%left		<str_val>		L_SQUARE_BRACKET
%left		<str_val>		R_SQUARE_BRACKET

%%

Program:	Function Program { }
		| { $$ = new std::string(); }
		;

Function:	FUNCTION IDENTIFIER SEMICOLON BEGIN_PARAMS Declaration_blk END_PARAMS BEGIN_LOCALS
		 Declaration_blk END_LOCALS BEGIN_BODY Statement_blk END_BODY { cout << BOLDMAGENTA << *((std::string*)$5) << ' ' << *((std::string*)$8) << endl << RESET;  }
		;

Declaration_blk:	Declaration SEMICOLON Declaration_blk { $$ = new std::string(*((std::string*)$1)
								 + ';' + *((std::string*)$3));}
			| { $$ = new std::string(); }
			;


Declaration:	IDENTIFIER Identifier_blk COLON Array_declaration INTEGER {
 $$ = new std::string(*((std::string*)$1) + *((std::string*)$2) + ":" + *((std::string*)$4) + "integer"); }
		;

Identifier_blk: COMMA IDENTIFIER Identifier_blk { $$ = new std::string(',' + *((std::string*)$2) + *((std::string*)$3)); }
		| {$$ = new std::string();}
		;

Array_declaration:	ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF { $$ = new std::string("array[" + *((std::string*)$3) + "] of ");	}
			| { $$ = new std::string(); }
			;

Statement_blk:	Statement SEMICOLON Statement_blk { }
		| { $$ = new std::string(); }
		;

Statement:	Var ASSIGN Expression {}
		| IF Bool_exp THEN Statement SEMICOLON Statement_blk Else_blk ENDIF{}
		| WHILE Bool_exp BEGINLOOP Statement SEMICOLON Statement_blk ENDLOOP {}
		| DO BEGINLOOP Statement SEMICOLON Statement_blk ENDLOOP WHILE Bool_exp {}
		| READ Var Var_blk {}
		| WRITE Var Var_blk {}
		| CONTINUE {}
		| RETURN Expression {}
		;

Else_blk:	ELSE Statement SEMICOLON Statement_blk {}
		| { $$ = new std::string(); }
		;

Bool_exp:	Relation_and_exp Or {}
		;

Or:		OR Relation_and_exp Or {}
		| { $$ = new std::string(); }
		;

Relation_and_exp:	Relation_exp And {}
			;

And:		AND Relation_exp And {}
		| { $$ = new std::string(); }
		;

Relation_exp:	Not Expression Comp Expression {}
		| Not TRUE {}
		| Not FALSE {}
		| Not L_PAREN Bool_exp R_PAREN {}
		;

Not:		NOT { $$ = $1; }
		| { $$ = new std::string(); }
		;

Comp:		EQ { $$ = $1; }
		| LT { $$ = $1; }
		| GT { $$ = $1; }
		| NEQ { $$ = $1; }
		| LTE { $$ = $1; }
		| GTE { $$ = $1; }
		;

Expression:	Multiplicative_exp Multiplicative_exp_blk {}
		;

Multiplicative_exp_blk:	Multiplicative_exp_add Multiplicative_exp_blk {}
			| Multiplicative_exp_sub Multiplicative_exp_blk {}
			| { $$ = new std::string(); }
			;

Multiplicative_exp_add:	ADD Multiplicative_exp { }
			;

Multiplicative_exp_sub:	SUB Multiplicative_exp {  }
			;

Multiplicative_exp:	Term Term_blk { }
			;

Term_blk:	MULT Term Term_blk { }
		| DIV Term Term_blk { }
		| MOD Term Term_blk { }
		| { $$ = new std::string(); }
		;

Var:		IDENTIFIER { $$ = $1; }
		| IDENTIFIER L_SQUARE_BRACKET Expression R_SQUARE_BRACKET { $$ = new string(*((std::string*)$1) + '[' + *((std::string*)$2) + ']') }
		;

Var_blk:	COMMA Var Var_blk { }
		| { $$ = new std::string(); }
		;

Term:		SUB Var { }
		| Var { }
		| SUB NUMBER { }
		| NUMBER { }
		| SUB L_PAREN Expression R_PAREN { }
		| L_PAREN Expression R_PAREN { }
		| IDENTIFIER  L_PAREN Expression Expression_blk R_PAREN { }
		| IDENTIFIER L_PAREN R_PAREN { }
		;

Expression_blk: COMMA Expression Expression_blk { }
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


