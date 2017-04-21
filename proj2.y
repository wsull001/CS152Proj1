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

%start	Program 

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

%type	<int_val>	Function
%type	<int_val>	Statement_blk
%type 	<int_val>	Statement
%type	<int_val>	Else_blk
%type	<int_val>	Bool_exp
%type	<int_val>	Or
%type	<int_val>	Relation_and_exp
%type	<int_val>	Not
%type	<int_val>	Comp
%type	<int_val>	Expression


%left	PLUS

%%

Program:	Function Program |
		;

Function:	FUNCTION IDENTIFIER SEMICOLON BEGIN_PARAMS DECLARATION_BLK END_PARAMS BEGIN_LOCALS
		 DECLARATION END_LOCALES BEGIN_BODY Statement_blk END_BODY ;

Statement_blk:	Statement SEMICOLON Statement_blk | ;

Statement:	VAR SEMICOLON EQ EXPRESSION |
		IF Bool_exp BEGIN_LOOP Statement SEMICOLONO Statement_blk ELSE|
		WHILE Bool_exp BEGIN_LOOP Statement SEMICOLON Statement_blk END_LOOP|
		DO BEGIN_LOOP Statement SEMICOLON Statement_blk END_LOOP WHILE Bool_exp|
		READ VAR_BLK|
		WRITE VAR_BLK|
		CONTINUE|
		RETURN EXPRESSION ;

Else_blk:	ELSE Statement SEMICOLON Statement_blk | ;

Bool_exp:	RELATION_AND_EXP Or;

Or:		OR RELATION_AND_EXP Or | ;

Relation_and_exp:	Relation_exp Amd ;

And:		AND Relation_Exp And | ;

Relation_Exp:	Not Expression Comp Expression | Not TRUE | Not FALSE |
		Not L_PAREN Bool_exp R_PAREN ;

Not:		NOT | ;

Comp:		EQ| LT | GT | NEQ | LTE | GTE ;

Expression:

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


