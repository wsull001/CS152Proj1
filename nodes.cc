#include "nodes.h"

WhileStmt::WhileStmt( int c1, BoolExpr* c2, int c3, Statements* c4, int c5) {
    string startlbl = newLabel();
    string endlbl = newLabel();

    code << ": " << startlbl << std::endl;
    code << c2->code.str();
    string myTmp = newTemp(code);
    code << "! " << myTmp << ", " <<  c2->val << std::endl;
    code << "?:= " << endlbl << ", " << myTmp << std::endl;
    for (auto i : *c4) {
      code << i->code.str();
    }
    code << ":= " << startlbl << std::endl;
    code << ": " << endlbl << std::endl;

  }


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
  code << c3->code.str();
  if(c1->index != ""){
    code << "=[] " + c1->val + ", " + c1->index << endl;
  } else {
    code << "= " + c1->val + ", " + c3->val << endl; 
  }
}

IfThenStmt::IfThenStmt( int c1, BoolExpr* c2, int c3, Statements* c4, int c5 ) {
    after = newLabel();
    code << c2->code.str();
    string temp = newTemp(code);
    code << "! " << temp << ", " << c2->val << endl;
    code << "?:= " << after << ", " << temp << endl;
    for(auto st: *c4){
      code << st->code.str();
    }
    code << ": " << after << endl;
}

IfThenElseStmt::IfThenElseStmt( int c1, BoolExpr* c2, int c3, Statements* c4, int c5,
		  Statements* c6, int c7 ) {

}


 
