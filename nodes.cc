#include "nodes.h"



Expression::Expression(Var* c1) {
    val = c1->val;
}

ReadStmt::ReadStmt( int c1, list<Var*>* c2 ) {
  for(auto var : *c2){
    if(var->expression_val == ""){
      this->code << ".< " + var->val;
    }
    else{
      this->code << "[].< " + var->val + ',' + var->expression_val;
    }
  }
}


WriteStmt::WriteStmt( int c1, list<Var*>* c2 ) {
  for(auto var : *c2){
    if(var->expression_val == ""){
      this->code << ".> " + var->val;
    }
    else{
      this->code << "[].> " + var->val + ',' + var->expression_val;
    }
  }
}


 
