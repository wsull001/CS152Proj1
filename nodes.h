// -*- c++ -*-
// nodes.h

// #include "heading.H"  // for tesing only.  Else comment this out

// Definitions of node classes, i.e., translation records.
// A work in progress


// External global variables
extern ostringstream code;                            // Where target code goes
extern ostringstream init;             // Where target initialization code goes
extern ostringstream decs;                      // Where target declarations go
extern int yylineno;                           // defined & maintained in lex.c
extern char* yytext;                           // defined & maintained in lex.c
extern map< int, string > decode;              // MiniJava-to-C op-decode table
extern string compilerName;               // initialized from argv[0] in main()

// Obsolete stuff:
// extern SemanticType* theIntType;    // global entity for MiniJava's Int type
// extern SemanticType* theIntArrayType;       // ... for MiniJava's Int[] type
// extern SemanticType* theBooleanType;      // ... for MiniJava's Boolean type
// extern SemanticType* theVoidPtrType;        
// extern SemanticType* theWordPtrType;        
// extern Program* root;                      // pointer to root of syntax tree

class BoolExpr;

class Function;
typedef list<Function*>     Functions;

class Declaration;
typedef list<Declaration*>  Declarations; 

class Statement;
typedef list<Statement*>    Statements;

class Var;
typedef list<Var*>          Vars;

class Expression;
typedef list<Expression*>   Expressions;

struct Node {
public:
  Node() : lineNo(yylineno), nextTok(yytext) {}
  virtual ~Node() {};
  string pos() {      // for reporting errors, which we do only from nodes
    return "At symbol \"" + nextTok + "\" on line " + itoa(lineNo) +",\n";
  }  

  // Declare code and place here.

private:
  int lineNo;             // lineNo at Node's construction is used in pos()
  string nextTok;        // nextTok at Node's construction is used in pos()
};  

class Statement : public Node {
public:
  virtual ~Statement(){};
};

class AssignmentStmt : public Statement {
public:   
  AssignmentStmt( Var* c1, int c2, Expression* c3 ) {}
};

class IfThenStmt : public Statement {
public:   
public:   
  IfThenStmt( int c1, BoolExpr* c2, int c3, Statements* c4, int c5 ) {}
};

class IfThenElseStmt : public Statement {
public:    
  IfThenElseStmt( int c1, BoolExpr* c2, int c3, Statements* c4, int c5,
		  Statements* c6, int c7 ) {}
};

class WhileStmt : public Statement {
public:   
  WhileStmt( int c1, BoolExpr* c2, int c3, Statements* c4, int c5) {}
};

class DoWhileStmt : public Statement {
public:   
  DoWhileStmt( int c1, int c2, Statements* c3, int c4, int c5,
	       BoolExpr* c6 ){}
};

class ReadStmt : public Statement {
public:   
  ReadStmt( int c1, Vars* c2 ) {}
};

class WriteStmt : public Statement {
public:   
  WriteStmt( int c1, Vars* c2 ) {}
};

class ContinueStmt : public Statement {
public:
  ContinueStmt( int c1 ) {}
};

class ReturnStmt : public Statement {
public:   
  ReturnStmt( int c1, Expression* c2 ) {}
};

class BoolExpr    : public Node {
public:   
  BoolExpr( Expression* c1, int c2, Expression* c3 ) {}
  BoolExpr( BoolExpr* c1,   int c2, BoolExpr* c3 ) {}
  BoolExpr( int c1, BoolExpr* c2 ) {}
  BoolExpr( int c1 ) {}
  BoolExpr( int c1, BoolExpr* c2, int c3 ) {}
  BoolExpr( int c1, int c2, int c3 ) {}
};

class Expression  : public Node {
public:   
  Expression( Var* c1 ) {}  // Var
  Expression( int c1 ) {}  // NUMBER 
  Expression( int c1, Expression* c2, int c3 ) {} // '(" Expression ')'
  Expression( string* c1, int c2, Expressions* c3, int c4 ) {} 
  Expression( Expression* c1, int c2, Expression* c3 ) {}
  Expression( int c2, Expression* c3 ) {}
};

class Var         : public Node {
public:
  Var( string* c1 ) {}
  Var( string* c1, int c2, Expression* c3, int c4 ) {} 
};



class Declaration : public Node {
public:
  Declaration( list<string*>* c1, int c2, int c3 ) 
  {};  
  Declaration( list<string*>* c1, int c2, int c3, int c4, int c5, int c6,
	       int c7, int c8 )
  { }
};


class Function    : public Node {
public:
  Function(int c1, string* c2, int c3, int c4, Declarations* c5, int c6,
      int c7, Declarations* c8, int c9, int c10, Statements* c11, int c12)
  {
    // emit MIL-code function declaration for c2
    for( auto it : *c5  ) { /* process it */ };   
    for( auto it : *c8  ) { /* process it */ };   
    for( auto it : *c11 ) { /* process it */ };   
  }
};

class Program     : public Node {    
public:
  Program(Functions *c1) 
  { for( auto it : *c1 ) { /* process it */ } }  
};


 
