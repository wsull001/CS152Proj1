#ifndef TREE_H
#define TREE_H
#include <unordered_map>
#include <string>
#include <stdlib.h>
#include <stdio.h>
#include <fstream>


extern std::string yytext;
extern int yylineno;


struct Node {
  
  Node() : lineNo(yylineno), nextTok(yytext) {};
  virtual ~Node() {};
  std::string pos() { return "At symbol \"" + nextTok 
    + "\" on line " + std::to_string(lineNo) + ",\n"; }
  virtual void analyze() = 0;
  virtual void gen() = 0;
  private:
    int lineNo;
    std::string nextTok;
};



#endif
