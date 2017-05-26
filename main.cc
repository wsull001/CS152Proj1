// -*- c++ -*- 
// main.cc

#include "heading.H"
#include "nodes.h"

// Globals
// int yylineno = 1;
extern int yydebug;
Program* root;     // pointer to root gets set by Program's constructor
ostringstream decs;     // holds gen()-emitted target-code declarations
ostringstream init;   // holds gen()-emitted intialization instructions
ostringstream code;     // holds gen()-emitted target-code instructions
string compilerName; // initialized by main() for use in error messages
int yyparse();          // prototype of bison-generated parser function

string preamble =
   "// beginning of preamble  ================================\n\
    using namespace std;                                      \n\
    #include<string>            // Write out the preamble     \n\
    #include<iostream>                                        \n\
    // end of preamble and beginning of main declarations ====\n";

string midamble =
   "// end of declarations and beginning of midamble  ========\n\
    main() {                    // main() of target code      \n";

string postamble =
   "// end of main code and beginning of postamble ===========\n\
    HALT:;                      // to stop                    \n\
    } // end of main            // end of postamble           \n";



int main( int argc, char* argv[] ) {  
  // yydebug = 1;          // uncomment to enable parser debugging
  // Allow for command-line specification of MiniJava source file
  if ( argc > 1  &&  freopen( argv[1], "r", stdin) == NULL ) {
    cerr << argv[0] << ": file " << argv[1]; 
    cerr << " cannot be opened.\n";
    exit( 1 ); 
  }

  compilerName = argv[0];           // For use in error messages
  yyparse();                                // build syntax tree

}

// These should create a name and install it into the appropriate table.
// It's attributes can be filled in later.

string newVar()   {
  static int counter = 0;
  return "Var" + itoa(counter++);
}

string newArry()  {
  static int counter = 0;
  return "Arry" + itoa(counter++);
}

string newParam() {
  static int counter = 0;
  return "Param" + itoa(counter++);
}

string newFunct() {
  static int counter = 0;
  return "Funct" + itoa(counter++);
}

string newTemp()  {
  static int counter = 0;
  return "Temp" + itoa(counter++);
}

string newLabel() {
  static int counter = 0;
  return "Label" + itoa(counter++);
}


  // The rest is left over from my MiniJava compiler  THP
  // root->install();            // installation pass through Decls
  // root->analyze();                              // analysis pass
  // root->gen();                           // code generation pass
  // cout << preamble;
  // cout << decs.str();            // Write out the dec(laration)s
  // cout << midamble;
  // cout << init.str();    // Write out code to initialize vtables
  // cout << code.str();                      // Write out the code
  // cout << postamble;


