/* Mini Calculator */
/* calc.y */

%{
#include "heading.h"
int yyerror(char *s);
int yylex(void);
%}

%union{
  int		int_val;
  std::string*	op_val;
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
%token	<int_val>	IDENTIFIER
%token	<int_val>	NUMBER

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
%type	<int_val>	Multiplicative_exp_blk
%type	<int_val>	Multiplicative_exp_add
%type	<int_val>	Multiplicative_exp_sub
%type	<int_val>	Multiplicative_exp
%type	<int_val>	Term_blk
%type	<int_val>	Var
%type	<int_val>	Term
%type	<int_val>	Expression_blk
%type	<int_val>	Identifier_blk


%left	PLUS

%%

Program:	Function Program |
		;

Function:	FUNCTION IDENTIFIER SEMICOLON BEGIN_PARAMS Declaration_blk END_PARAMS BEGIN_LOCALS
		 Declaration END_LOCALS BEGIN_BODY Statement_blk END_BODY ;

Declaration_blk:	Declaration SEMICOLON Declaration_blk | ;

Declaration:	IDENTIFIER Identifier_blk COLON Array_declaration INTEGER ;

Identifier_blk: COMMA IDENTIFIER Identifier_blk | ;

Array_declaration:	ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF | ;

Statement_blk:	Statement SEMICOLON Statement_blk | ;

Statement:	Var SEMICOLON EQ Expression |
		IF Bool_exp BEGINLOOP Statement SEMICOLON Statement_blk ELSE |
		WHILE Bool_exp BEGINLOOP Statement SEMICOLON Statement_blk ENDLOOP|
		DO BEGINLOOP Statement SEMICOLON Statement_blk ENDLOOP WHILE Bool_exp|
		READ Var Var_blk|
		WRITE Var Var_blk|
		CONTINUE|
		RETURN Expression ;

Else_blk:	ELSE Statement SEMICOLON Statement_blk | ;

Bool_exp:	Relation_and_exp Or;

Or:		OR Relation_and_exp Or | ;

Relation_and_exp:	Relation_exp And ;

And:		AND Relation_exp And | ;

Relation_exp:	Not Expression Comp Expression | Not TRUE | Not FALSE |
		Not L_PAREN Bool_exp R_PAREN ;

Not:		NOT | ;

Comp:		EQ| LT | GT | NEQ | LTE | GTE ;

Expression:	Multiplicative_exp Multiplicative_exp_blk ;

Multiplicative_exp_blk:	Multiplicative_exp_add Multiplicative_exp_blk |
			Multiplicative_exp_sub Multiplicative_exp_blk |
			 | ;
Multiplicative_exp_add:	ADD Multiplicative_exp;

Multiplicative_exp_sub:	SUB Multiplicative_exp;

Multiplicative_exp:	Term Term_blk | Term ;

Term_blk:	MULT Term Term_blk | DIV Term Term_blk | MOD Term Term_blk| ;

Var:		IDENTIFIER | IDENTIFIER L_SQUARE_BRACKET Expression R_SQUARE_BRACKET ;

Var_blk:	COMMA Var Var_blk | ;

Term:		SUB Var | Var | SUB NUMBER | NUMBER | SUB L_PAREN Expression R_PAREN |
		SUB L_PAREN Expression R_PAREN | IDENTIFIER  L_PAREN Expression Expression_blk R_PAREN |
		IDENTIFIER L_PAREN R_PAREN ;

Expression_blk: COMMA Expression Expression_blk | ;



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


