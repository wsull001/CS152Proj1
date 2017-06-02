#include "nodes.h"



Expression::Expression(Var* c1) {
    val = c1->val;
}

ReadStmt::ReadStmt( int c1, list<Var*>* c2 ) {
  for(auto var : *c2){
    if(var->index == ""){
      this->code << ".< " + var->val <<endl;
    }
    else{
      this->code << "[].< " + var->val + ", " + var->index <<endl;
    }
  }
}


WriteStmt::WriteStmt( int c1, list<Var*>* c2 ) {
  for(auto var : *c2){
    if(var->index == ""){
      this->code << ".> " + var->val <<endl;
    }
    else{
      this->code << "[].> " + var->val + ", " + var->index << endl;
    }
  }
}

AssignmentStmt::AssignmentStmt( Var* c1, int c2, Expression* c3 ) {
  if(c1->index != ""){
    code << "=[] " + c1->val + ", " + c1->index << endl;
  } else {
    code << "= " + c1->val + ", " + c3->val << endl; 
  }
}


 
