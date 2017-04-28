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
%token	<str_val>	ASSIGN
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

Program:	Function Program { cout << "Program -> Function Program" << endl;}
		| { cout << "Program -> epsilon" << endl; }
		;

Function:	FUNCTION IDENTIFIER SEMICOLON BEGIN_PARAMS Declaration_blk END_PARAMS BEGIN_LOCALS
		 Declaration_blk END_LOCALS BEGIN_BODY Statement_blk END_BODY { cout << "Function - > FUNCTION " << *((std::string*)$2) << " SEMICOLON BEGIN_PARAMS Declaration_blk END_PARAMS BEGIN_LOCALS Declaration END_LOCALS BEGIN_BODY Statement_blk END_BODY" << endl; }
		;

Declaration_blk:	Declaration SEMICOLON Declaration_blk { cout << "Declaration_blk -> Declaration SEMICOLON Declaration_blk" << endl; }
			| { cout << "Declaration_blk -> epsilon" << endl; }
			;

Declaration:	IDENTIFIER Identifier_blk COLON Array_declaration INTEGER { cout << "Declaration -> " << *((std::string*)$1) << " Identifier_blk COLON Array_declaration INTEGER" << endl; }
		;

Identifier_blk: COMMA IDENTIFIER Identifier_blk { cout << "Identifier_blk -> COMMA " << *((std::string*)$2) << " Identifier_blk" << endl; }
		| { cout << "Identifier_blk -> epsilon" << endl; }
		;

Array_declaration:	ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF { cout << "Array_declaration -> ARRAY L_SQUARE_BRACKET " << $3 << "R_SQUARE_BRACKET OF" << endl; }
			| { cout << "Array_declaration -> epsilon" << endl; }
			;

Statement_blk:	Statement SEMICOLON Statement_blk { cout << "Statement_blk -> Statement SEMICOLON Statement_blk" << endl; }
		| { cout << "Statement_blk -> epsilon" << endl; }
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
		| {cout << "Else_blk -> epsilon" << endl;}
		;

Bool_exp:	Relation_and_exp Or {cout << "Bool_exp -> Relation_and_exp Or" << endl;}
		;

Or:		OR Relation_and_exp Or {cout << "OR -> OR Relation_and_exp Or" << endl;}
		| {cout << "OR -> epsilon" << endl;}
		;

Relation_and_exp:	Relation_exp And {cout << "Relation_and_exp -> Relation_exp And" << endl;}
			;

And:		AND Relation_exp And {cout << "And -> AND Relation_exp And" << endl;}
		| {cout << "And -> epsilon" << endl;}
		;

Relation_exp:	Not Expression Comp Expression {cout << "Relation_exp -> Not Expression Comp Expression" << endl;}
		| Not TRUE {cout << "Relation_exp -> Not TRUE" << endl;}
		| Not FALSE {cout << "Relation_exp -> Not FALSE" << endl;}
		| Not L_PAREN Bool_exp R_PAREN {cout << "Relation_exp -> Not L_PAREN Bool_exp R_PAREN" << endl;}
		;

Not:		NOT {cout << "Not -> NOT" << endl;}
		| {cout << "Not -> epsilon" << endl;}
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
			| {cout << "Multiplicative_exp_blk -> epsilon" << endl;}
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
		| {cout << "Term_blk -> epsilon" << endl;}
		;

Var:		IDENTIFIER { cout << "Var -> " << *((std::string*)$1) << endl;}
		| IDENTIFIER L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {cout << "Var ->" << *((std::string*)$1) << "L_SQUARE_BRACKET Expression R_SQUARE_BRACKET" << endl;}
		;

Var_blk:	COMMA Var Var_blk {cout << "Var_blk -> COMMA VAR Var_blk" << endl;}
		| {cout << "Var_blk -> epsilon" << endl;}
		;

Term:		SUB Var { cout << "SUB Var" << endl;}
		| Var {cout << "Term -> Var" << endl;}
		| SUB NUMBER {cout << "Term -> SUB " << $2 << endl;}
		| NUMBER {cout << "Term -> " << $1 << endl;}
		| SUB L_PAREN Expression R_PAREN { cout << "Term -> SUB L_PAREN Expression R_PAREN" << endl; }
		| SUB L_PAREN Expression R_PAREN {cout << "Term -> SUB L_PAREN Expression R_PAREN" << endl; }
		| IDENTIFIER  L_PAREN Expression Expression_blk R_PAREN {cout << "Term -> " << *((std::string*)$1) << " L_PAREN Expression Expression_blk R_PAREN" << endl;}
		| IDENTIFIER L_PAREN R_PAREN {cout << "Term -> " << *((std::string*)$1) << " L_PAREN R_PAREN" << endl;}
		;

Expression_blk: COMMA Expression Expression_blk { cout << "Expression_blk -> COMMA Expression Expressin_blk" << endl;}
		| {cout << "Expression_blk -> epsilon" << endl; }
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


