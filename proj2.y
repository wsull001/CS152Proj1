/* Mini Calculator */
/* calc.y */

%{
#include "heading.h"
int yyerror(char *s);
int yylex(void);
%}

%union{
  int		int_val;
  std::string*	str_val;
  std::string*	id_val;
}

%start	Program 

%token	<str_val>	INTEGER_LITERAL
%token	<str_val>	FUNCTION
%token	<str_val>	BEGIN_PARAMS
%token	<str_val>	END_PARAMS
%token	<str_val>	BEGIN_LOCALS
%token	<str_val>	END_LOCALS
%token	<str_val>	BEGIN_BODY
%token	<str_val>	END_BODY
%token	<str_val>	INTEGER
%token	<str_val>	ARRAY
%token	<str_val>	OF
%token	<str_val>	IF
%token	<str_val> 	THEN
%token	<str_val>	ENDIF
%token	<str_val>	ELSE
%token	<str_val>	WHILE
%token	<str_val>	DO
%token	<str_val>	BEGINLOOP
%token	<str_val>	ENDLOOP
%token	<str_val>	CONTINUE
%token	<str_val>	READ
%token	<str_val>	WRITE
%token	<str_val>	AND
%token	<str_val>	OR
%token	<str_val>	NOT
%token	<str_val>	TRUE
%token	<str_val>	FALSE
%token	<str_val>	RETURN
%token	<str_val>	SUB
%token	<str_val>	ADD
%token	<str_val>	MULT
%token	<str_val>	DIV
%token	<str_val>	MOD
%token	<str_val>	EQ
%token	<str_val>	NEQ
%token	<str_val>	LT
%token	<str_val>	GT
%token	<str_val>	LTE
%token	<str_val>	GTE
%token	<str_val>	SEMICOLON
%token	<str_val>	COLON
%token	<str_val>	COMMA
%token	<str_val>	L_PAREN
%token	<str_val>	R_PAREN
%token	<str_val>	L_SQUARE_BRACKET
%token	<str_val>	R_SQUARE_BRACKET
%token	<str_val>	IDENTIFIER
%token	<str_val>	NUMBER

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


%left	PLUS

%%

Program:	Function Program |
		;

Function:	FUNCTION IDENTIFIER SEMICOLON BEGIN_PARAMS Declaration_blk END_PARAMS BEGIN_LOCALS
		 Declaration END_LOCALS BEGIN_BODY Statement_blk END_BODY {}
		;

Declaration_blk:	Declaration SEMICOLON Declaration_blk {}
			| {}
			;

Declaration:	IDENTIFIER Identifier_blk COLON Array_declaration INTEGER {}
		;

Identifier_blk: COMMA IDENTIFIER Identifier_blk {}
		| {}
		;

Array_declaration:	ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF {}
			| {}
			;

Statement_blk:	Statement SEMICOLON Statement_blk {}
		| {}
		;

Statement:	Var SEMICOLON EQ Expression {}
		| IF Bool_exp BEGINLOOP Statement SEMICOLON Statement_blk ELSE {}
		| WHILE Bool_exp BEGINLOOP Statement SEMICOLON Statement_blk ENDLOOP {}
		| DO BEGINLOOP Statement SEMICOLON Statement_blk ENDLOOP WHILE Bool_exp {}
		| READ Var Var_blk {}
		| WRITE Var Var_blk {}
		| CONTINUE {}
		| RETURN Expression {}
		;

Else_blk:	ELSE Statement SEMICOLON Statement_blk {}
		| {}
		;

Bool_exp:	Relation_and_exp Or {}
		;

Or:		OR Relation_and_exp Or {}
		| {}
		;

Relation_and_exp:	Relation_exp And {}
			;

And:		AND Relation_exp And {}
		| {}
		;

Relation_exp:	Not Expression Comp Expression {}
		| Not TRUE {}
		| Not FALSE {}
		| Not L_PAREN Bool_exp R_PAREN {}
		;

Not:		NOT {}
		| {}
		;

Comp:		EQ {}
		| LT {}
		| GT {}
		| NEQ {}
		| LTE {}
		| GTE {}
		;

Expression:	Multiplicative_exp Multiplicative_exp_blk {}
		;

Multiplicative_exp_blk:	Multiplicative_exp_add Multiplicative_exp_blk {}
			| Multiplicative_exp_sub Multiplicative_exp_blk {}
			| {}
			;

Multiplicative_exp_add:	ADD Multiplicative_exp {}
			;

Multiplicative_exp_sub:	SUB Multiplicative_exp {}
			;

Multiplicative_exp:	Term Term_blk {}
			| Term {}
			;

Term_blk:	MULT Term Term_blk {}
		| DIV Term Term_blk {}
		| MOD Term Term_blk {}
		| {}
		;

Var:		IDENTIFIER {}
		| IDENTIFIER L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {}
		;

Var_blk:	COMMA Var Var_blk {}
		| {}
		;

Term:		SUB Var {}
		| Var {}
		| SUB NUMBER {}
		| NUMBER {}
		| SUB L_PAREN Expression R_PAREN {}
		| SUB L_PAREN Expression R_PAREN {}
		| IDENTIFIER  L_PAREN Expression Expression_blk R_PAREN {}
		| IDENTIFIER L_PAREN R_PAREN {}
		;

Expression_blk: COMMA Expression Expression_blk {}
		| {}
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


