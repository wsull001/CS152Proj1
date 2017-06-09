// -*- c++ -*-
// nodes.h

#ifndef BRUH_GIT_GUD
#define BRUH_GIT_GUD

 #include "heading.H"  // for tesing only.  Else comment this out

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
extern int decCnt;
extern int loopCount;                     // preston's loopcount idea
extern int lastFuncLine;

extern list<fcall> fcalls;

extern map<string,int> symtab;
extern map<string, int> scope;
const int integer = 0;
const int arraytype = 1;
const int function = 2;




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
  string val, before, after;
  ostringstream code;
  Node() : lineNo(yylineno), nextTok(yytext) {}
  virtual ~Node() {};
  void error(string err){
    cerr << BOLDBLACK << compilerName << ':' << BOLDRED << " fatal: " << RESET << pos() << "\t"
    << err << endl;
    exit( 1 );
  }
  void error(string err, int lineNum){
    cerr << BOLDBLACK << compilerName << ':' << BOLDRED << " fatal: " << RESET << "On line " << lineNum << endl  << "\t"
    << err << endl;
    exit( 1 );
  }
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
  AssignmentStmt( Var* c1, int c2, Expression* c3 );
};

class IfThenStmt : public Statement {
public:   
public:   
  IfThenStmt( int c1, BoolExpr* c2, int c3, Statements* c4, int c5 );
};

class IfThenElseStmt : public Statement {
public:    
  IfThenElseStmt( int c1, BoolExpr* c2, int c3, Statements* c4, int c5,
		  Statements* c6, int c7 );
};

class WhileStmt : public Statement {
public:   
  WhileStmt( int c1, BoolExpr* c2, int c3, Statements* c4, int c5); 
};

class DoWhileStmt : public Statement {
public:   
  DoWhileStmt( int c1, int c2, Statements* c3, int c4, int c5,
	       BoolExpr* c6 );
};

class ReadStmt : public Statement {
public:   
  ReadStmt( int c1, list<Var*>* c2 );
};

class WriteStmt : public Statement {
public:   
  WriteStmt( int c1, list<Var*>* c2 ); 
};


class ContinueStmt : public Statement {
public:
  ContinueStmt( int c1 ) {
    if (loopCount == 0) error("Continue statement outside of loop body");
    code << "{" << endl;
  }
};

class ReturnStmt : public Statement {
public:   
  ReturnStmt( int c1, Expression* c2 );
};

class BoolExpr    : public Node {
public:   
//  Combining these both into one constructor. If things break, revert to two
//  BoolExpr( Expression* c1, int c2, Expression* c3 ) {}
//  BoolExpr( BoolExpr* c1,   int c2, BoolExpr* c3 ) {}

  BoolExpr(Node *c1, int c2, Node *c3) {
    code << c1->code.str() << c3->code.str();
    val = newTemp(code);
    switch(c2) {
      case 0:
        //EQ
        code << "== "; 
        break;
      case 1:
        //NE
        code << "!= ";
        break;
      case 2:
        //LT
        code << "< ";
        break;
      case 3:
        //GT
        code << "> ";
        break;
      case 4:
        //LE
        code << "<= ";
        break;
      case 5:
        //GE
        code << ">= ";
        break;
      case 6:
        //AND
        code << "&& ";
        break;
      case 69:
        //OR
        code << "|| ";
        break;
    }
    
    code << val << ", " << c1->val << ", " << c3->val << endl;    
  }
  
  BoolExpr( int c1, BoolExpr* c2 ) {
    code << c2->code.str();
    val = newTemp(code);
    code << "! " << val << ", " << c2->val << endl;
  }

  BoolExpr( int c1 ) { val = itoa(c1); }
};

class Expression  : public Node {
public:   
  Expression( Var* c1 );  // Var
  Expression( int c1 ) {
    val = itoa(c1);
  }  // NUMBER 
  Expression( string* c1, int c2, Expressions* c3, int c4 ) {
    /*if (!symtab.count(*c1)){
      error("Undefined function " + *c1);
    } else if (symtab[*c1] != function) {
      error("Symbol " + *c1 + " is not a function");
    }*/
    fcalls.push_back(fcall(*c1, yylineno));
    for (auto i : *c3) {
      code << i->code.str();
      code << "param " << i->val << std::endl;
    }
    
    val = newTemp(code);

    code << "call " << *c1 << ", " << val << std::endl;

  } 
  Expression( Expression* c1, int c2, Expression* c3 ) {
    code << c1->code.str() << c3->code.str();
    val = newTemp(code);
    if(c2 == '+'){
      code << "+ " + val + ", " + c1->val + ", " + c3->val << endl;
    } else if (c2 == '-'){
      code << "- " + val + ", " + c1->val + ", " + c3->val << endl;
    } else if (c2 == '*'){
      code << "* " + val + ", " + c1->val + ", " + c3->val << endl;
    } else if (c2 == '%'){
      code << "% " + val + ", " + c1->val + ", " + c3->val << endl;
    } else {
      code << "/ " + val + ", " + c1->val + ", " + c3->val << endl;
    }
  }
  Expression( int c2, Expression* c3 ) {
    code << c3->code.str();
    val = newTemp(code);
    code << "- " << val << ", 0, " << c3->val << endl;
  }
};

class Var         : public Node {
public:
  string index;
  Var( string* c1 ) {
    if(!scope.count(*c1)){
      error("Symbol '" + *c1 + "' out of scope");
    } else if((scope[*c1] != integer)){
      error("attempt to access non integer as an integer");
    } else{
      val = *c1;
      index = "";
    }
  }
  Var( string* c1, int c2, Expression* c3, int c4 ) {
    code << c3->code.str();
    if(!scope.count(*c1)){
      error("Symbol '" + *c1 + "' out of scope");
    } else if((scope[*c1] != arraytype)){
      error("array acessed as a non array");
    } else {
      val = *c1;
      index = c3->val;
    }
  } 
};



class Declaration : public Node {
public:
  Declaration( list<string*>* c1, int c2, int c3, bool isParam=true ) {
    for (auto i : *c1) {
      if (symtab.count(*i) != 0 && symtab[*i] == function) {
        error("Identifier '" + *i + "' already exists as a function");
      } else {
        symtab[*i] = integer; //can't redeclare variables out of scope
      }
      if(scope.count(*i)) {
        error("Identifier '" + *i + "' already declared in scope");
      } else {
        scope[*i] = integer;
      }

      code << ". " << *i << endl;
      if (isParam) {
        code <<  "= " << *i << ", $" << decCnt++ << endl;;
      }
    }
  };  
  Declaration( list<string*>* c1, int c2, int c3, int c4, int c5, int c6,
	       int c7, int c8, bool isParam=true ) {
    for (auto i : *c1) {
      if (symtab.count(*i) != 0 && symtab[*i] == function) {
         error("Identifier '" + *i + "' already exists as a function");
      } else {
        symtab[*i] = arraytype;
      }
      if(scope.count(*i)) {
        error("Identifier '" + *i + "' already declared in scope");
      } else {
        scope[*i] = arraytype;
      }
      if(c5 <= 0){
        error("Array declared with size less than or equal to 0.");
      }
      code << ".[] " << *i << ", " << c5 << endl;
    }
  };
};


class Function    : public Node {
public:
  Function(int c1, string* c2, int c3, int c4, Declarations* c5, int c6,
      int c7, Declarations* c8, int c9, int c10, Statements* c11, int c12)
  {
    if (symtab.count(*c2)) {
      error("Function symbol '" + *c2 + "' used before", lastFuncLine);
    }
    symtab[*c2] = function;
    code << "func " << *c2 << std::endl;
    // emit MIL-code function declaration for c2
    for( auto it : *c5  ) { /* process it */ 
      code << it->code.str();
    };   
    for( auto it : *c8  ) { /* process it */ 
      code << it->code.str();
    };   
    for( auto it : *c11 ) { /* process it */ 
      code << it->code.str(); 
    }; 
    code << "endfunc" << endl;
  }
};

class Program     : public Node {    
public:
  Program(Functions *c1) 
  { 
    for (auto it : fcalls) {
      if (!symtab.count(it.id))  {
        cerr << BOLDBLACK << compilerName << ':' << BOLDRED << " fatal: " << RESET << "At symbol " << it.id << " on line " 
          << it.lineno << endl  << "\t" << "Not a valid identifier" << endl;
        exit(1);
      } else if (symtab[it.id] != function) {
        cerr << BOLDBLACK << compilerName << ':' << BOLDRED << " fatal: " << RESET << "At symbol " << it.id << " on line " 
          << it.lineno << endl  << "\t" << "Identifier not a function" << endl;
        exit(1);
      }
    }
    if (!symtab.count("main")) {
      cerr << BOLDBLACK << compilerName << ':' << BOLDRED << " fatal: " << RESET << "No main function in program" << endl;
      exit(1);
    }


    for( auto it : *c1 ) { /* process it */ 
      std::cout << it->code.str();
    } 
  
  }  

};


#endif //BRUH_GIT_GUD
 
