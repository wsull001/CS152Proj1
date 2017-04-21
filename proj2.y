/* Mini Calculator */
/* calc.y */

%{
#include "heading.h"
int yyerror(char *s);
int yylex(void);
%}

%union{
  int		int_val;
  string*	op_val;
}

%start	input 

%token	<int_val>	INTEGER_LITERAL
%token	<int_val>	FUNCTION
%token	<int_val>	BEGIN_PARAMS
%token	<int_val>	END_PARAMS
%token	<int_val>	BEGIN_LOCALS
%token	<int_val>	END_LOCALS
%token	<int_val>	BEGIN_BODY
%token	<int_val>	END_BODY
%token	<int_val>	INTEGER
%token	<int_val>	ARRAY
%token	<int_val>	OF
%token	<int_val>	IF
%token	<int_val> 	THEN
%token	<int_val>	ENDIF
%token	<int_val>	ELSE
%token	<int_val>	WHILE
%token	<int_val>	DO
%token	<int_val>	BEGINLOOP
%token	<int_val>	ENDLOOP
%token	<int_val>	CONTINUE
%token	<int_val>	READ
%token	<int_val>	WRITE
%token	<int_val>	AND
%token	<int_val>	OR
%token	<int_val>	NOT
%token	<int_val>	TRUE
%token	<int_val>	FALSE
%token	<int_val>	RETURN
%token	<int_val>	SUB
%token	<int_val>	ADD
%token	<int_val>	MULT
%token	<int_val>	DIV
%token	<int_val>	MOD
%token	<int_val>	EQ
%token	<int_val>	NEQ
%token	<int_val>	LT
%token	<int_val>	GT
%token	<int_val>	LTE
%token	<int_val>	GTE
%token	<int_val>	SEMICOLON
%token	<int_val>	COLON
%token	<int_val>	COMMA
%token	<int_val>	L_PAREN
%token	<int_val>	R_PAREN
%token	<int_val>	L_SQUARE_BRACKET
%token	<int_val>	R_SQUARE_BRACKET

%type	<int_val>	exp
%left	PLUS
%left	MULT

%%

input:		/* empty */
		| exp	{ cout << "Result: " << $1 << endl; }
		;

exp:		INTEGER_LITERAL	{ $$ = $1; }
		| exp PLUS exp	{ $$ = $1 + $3; }
		| exp MULT exp	{ $$ = $1 * $3; }
		;

%%

int yyerror(string s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c
  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}


