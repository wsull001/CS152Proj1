// -*- c++ -*-
// source.y for Mini-L
// Updated 9:00 AM 5/20/17

%{ // Everything from here to "%}" is copied verbatim to the top of source.y
#include "heading.H"
#include "nodes.h"
int yyerror( const char* s );
int yylex( void );
extern int decCnt;
extern map<string, int> scope;
bool isParam = false;
%}

%error-verbose

%union{

   // Here we define the types and names of the components of the
   // union type YYSTYPE, which is the type of yylval and of the
   // semantic portion of the parse-stack entries.

   // declarations of union members for lexical values of tokens
   int 		   junk;    	    // values for single-lexeme tokens
   int		   int_val;	    // values of integer literals
   string*	   str_val;	    // values of string literals
   string*	   ident;	    // points to identifiers' actual lexemes

   // declarations of union members for lexical values of non-terminals
   // that are pointers to translation records.
   Program*              program;
   list<Function*>*      functions;	// for the non-terminal "Functions"
   list<Declaration*>*   declarations;  // for the non-terminal "Declarations"
   list<Statement*>*     statements;   
   list<Var*>*           vars;
   list<Expression*>*    expressions;
   list<Expression*>*    nonemptyexpressionlist;
   list<string*>*        ids;
   Function*             function;   
   Declaration*          declaration;      
   Statement*            statement;
   BoolExpr*             boolexpr;
   Expression*           expression;
   Var*                  var;
 }

// Here is the  start symbol of the grammar.

%start               Program
 
// Here we specify the nonterminal symbols and which components of the
// union YYSTYPE their translation records will occupy.  By ourconvention,
// the union member for the semantic record for a given non-terminal has
// the same name as that symbol, but not capitalized., and its type is a
// pointer to an object of a class that haas the same name as that symbol,
// including capitalization.

//           member       non-termimnal
%type       <program>       Program
%type       <declarations>  Declarations
%type       <declaration>   Declaration
%type       <statements>    Statements
%type       <statement>     Statement
%type       <functions>     Functions
%type       <function>      Function
%type       <ids>           IDs
%type       <vars>          Vars
%type       <var>           Var
%type       <expressions>   Expressions
%type       <expression>    Expression
%type       <nonemptyexpressionlist> NonemptyExpressionList
%type       <boolexpr>      BoolExpr


// Here, in order of increasing precedence, are the names of the tokens,
// their associativity, and which components of the union YYSTYPE
// their lexical values will occupy.  This information is from:
// www.cs.ucr.edu/~gupta/teaching/152-17/Project-Phase-II/mini_l.html

// assoc      member        token
%nonassoc   <junk>          LO
%nonassoc   <junk>          INTEGER
%nonassoc   <junk>          ARRAY
%nonassoc   <junk>          FUNCTION
%nonassoc   <junk>          BEGINPARAMS
%nonassoc   <junk>          ENDPARAMS
%nonassoc   <junk>          BEGINLOCALS
%nonassoc   <junk>          ENDLOCALS
%nonassoc   <junk>          BEGINBODY
%nonassoc   <junk>          ENDBODY
%nonassoc   <junk>          BEGINLOOP
%nonassoc   <junk>          ENDLOOP
%token      <junk>          IF
%token      <junk>          THEN
%token      <junk>          ELSE
%token      <junk>          ENDIF
%token      <junk>          DO
%token      <junk>          WHILE
%token      <junk>          READ
%token      <junk>          WRITE
%token      <junk>          CONTINUE
%token      <junk>          RETURN
%token      <junk>          TRUE
%token      <junk>          FALSE
%right      <junk>          ASSGN   /* ":=" */
%token      <junk>          OF
%left       <junk>          OR
%left       <junk>          AND
%right      <junk>          NOT
%left       <junk>          NE
%left       <junk>          EQ
%left       <junk>          GE
%left       <junk>          GT
%left       <junk>          LE
%left       <junk>          LT
%left       <junk>          '-'    /* binary */
%left       <junk>          '+'
%left       <junk>          '%'
%left       <junk>          '/'
%left       <junk>          '*'
%right      <junk>          UMINUS
%left       <junk>          '['
%left       <junk>          ']'
%left       <junk>          '('
%left       <junk>          ')'
%right      <junk>          ','
%right      <junk>          ';'
%nonassoc   <junk>          ':'
%nonassoc   <junk>          HI
%token      <ident>         ID
%token      <int_val>       NUMBER


%%  // end of symbol specifications

// Here are the grammar rules and their associated semantic actions.

Functions    : /* empty */                         { $$ = new list<Function*>; }
             | Functions Function                    { ($$=$1)->push_back($2); }
             ;                    /* any possibly empty sequence of Functions */

Declarations : /* empty */                      { $$ = new list<Declaration*>; isParam = !isParam; if (isParam) scope.clear();}
             | Declarations Declaration              { ($$=$1)->push_back($2); }
             ;/* any possibly empty semicolon-terminated Declaration sequence */

Statements   : Statement ';'     { ($$ = new list<Statement*>)->push_back($1); }
             | Statements Statement ';'              { ($$=$1)->push_back($2); }
             ;    /* any nonempty sequence of semicolon-terminated Statements */

IDs          : ID                   { ($$ = new list<string*>)->push_back($1); }
             | IDs ',' ID                            { ($$=$1)->push_back($3); }
             ;                    /* any nonempty comma-separated list of IDs */

Vars         : Var                     { ($$ = new list<Var*>)->push_back($1); }
             | Vars ',' Var                          { ($$=$1)->push_back($3); }
             ;                   /* any nonempty comma-separated list of Vars */

Expressions  : /* empty */                       { $$ = new list<Expression*>; }
             | NonemptyExpressionList                               { $$ = $1; }
             ;      /* any possibly empty comma-separated list of Expressions */

NonemptyExpressionList
             : Expression                        { $$ = new list<Expression*>; $$->push_back($1)}
             | NonemptyExpressionList ',' Expression { ($$=$1)->push_back($3); }
             ;            /* any nonempty comma-separated list of Expressions */

Program      : Functions                              { $$ = new Program($1); }
             ;

Function     : FUNCTION ID ';'                   
               BEGINPARAMS Declarations ENDPARAMS
               BEGINLOCALS Declarations ENDLOCALS                            
 	             BEGINBODY   Statements   ENDBODY                         
                  { $$ = new Function($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12); decCnt = 0;}

             ;

Declaration  : IDs ':' INTEGER ';'           { $$ = new Declaration($1,$2,$3, isParam); }
             | IDs ':' ARRAY '[' NUMBER ']' OF INTEGER ';'  
                              { $$ = new Declaration($1,$2,$3,$4,$5,$6,$7,$8); }
	     ;

Statement    : Var ASSGN Expression       { $$ = new AssignmentStmt($1,$2,$3); }
             | IF BoolExpr THEN Statements ENDIF  
                                        { $$ = new IfThenStmt($1,$2,$3,$4,$5); }
	     | IF BoolExpr THEN Statements ELSE Statements ENDIF         
                              { $$ = new IfThenElseStmt($1,$2,$3,$4,$5,$6,$7); }
	     | WHILE BoolExpr BEGINLOOP Statements ENDLOOP       
                                         { $$ = new WhileStmt($1,$2,$3,$4,$5); }
	     | DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr
                                    { $$ = new DoWhileStmt($1,$2,$3,$4,$5,$6); }
             | READ Vars                           { $$ = new ReadStmt($1,$2); }
	           | WRITE Vars                         { $$ = new WriteStmt($1,$2); }
	           | CONTINUE                           { $$ = new ContinueStmt($1); }
             | RETURN Expression                 { $$ = new ReturnStmt($1,$2); }
             ;

 BoolExpr    : Expression EQ Expression         { $$ = new BoolExpr($1,0,$3); }
             | Expression NE Expression         { $$ = new BoolExpr($1,1,$3); }
             | Expression LT Expression         { $$ = new BoolExpr($1,2,$3); }
             | Expression GT Expression         { $$ = new BoolExpr($1,3,$3); }
             | Expression LE Expression         { $$ = new BoolExpr($1,4,$3); }
             | Expression GE Expression         { $$ = new BoolExpr($1,5,$3); }
	           | BoolExpr AND BoolExpr            { $$ = new BoolExpr($1,6,$3); }
	           | BoolExpr OR BoolExpr             { $$ = new BoolExpr($1,69,$3); }
             | NOT BoolExpr                     { $$ = new BoolExpr($1,$2); }
             | TRUE                             { $$ = new BoolExpr( 1); }
             | FALSE                            { $$ = new BoolExpr( 0); }
             | '(' BoolExpr ')'                                     { $$ = $2; }
	     ;

Expression   : Var                                  { $$ = new Expression($1); }
	           | NUMBER                               { $$ = new Expression($1); }
             | '(' Expression ')'                                   { $$ = $2; }
             | ID '(' Expressions ')'      { $$ = new Expression($1,$2,$3,$4); }
             | Expression '+' Expression      { $$ = new Expression($1,'+',$3); }
             | Expression '-' Expression      { $$ = new Expression($1,'-',$3); }
             | Expression '*' Expression      { $$ = new Expression($1,'*',$3); }
             | Expression '/' Expression      { $$ = new Expression($1,'/',$3); }
             | Expression '%' Expression      { $$ = new Expression($1,'%',$3); }
             | '-' Expression  %prec UMINUS   { $$ = new Expression($1,$2); }
             ;

 Var	     : ID                                 { $$ = new Var($1); }
             | ID '[' Expression ']'              { $$ = new Var($1,$2,$3,$4); }
             ;



%%  // end of rules

// Here are the definitions of yyerror, the function that reports 
// lexical and parse errors.  It's overloaded so that error messages
// can be either C strings or C++ strings.

int yyerror( string s ) {
  extern int yylineno;
  extern char* yytext;
  extern int charNo;
  extern std::string compilerName;
  
  cerr << BOLDBLACK << compilerName << ':' << yylineno << ':' << BOLDRED << " fatal: " << RESET;
  cerr << s << " at symbol \"" << yytext << "\"" << endl;
  exit( 1 );
}

int yyerror( const char* s ) { return yyerror( string(s) ); }






