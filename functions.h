//functions for proj2.y
//headers in this file

//includes
#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <map>
#include <stdlib.h>
#include "heading.h"
#include <cstdarg>






//functions

std::map<std::string, int> symbols; //0 for int, 1 for array, 2 for function
extern int yylineno;
extern int charNo;
extern std::string exec_name;

std::vector<std::string> split(std::string in, char delim) {
    std::vector<std::string> out;
    int pos = in.find(delim);
    int backpos = 0;
    while (pos != -1) {
        out.push_back(in.substr(backpos, pos - backpos));
        backpos=pos + 1; //shift backpos up
        pos=in.find(delim,backpos);
    }
    out.push_back(in.substr(backpos)); //push the rest of the string
    return out;

}

std::string* declrCode(std::string* declr) { //generate declaration statements for locals
    std::string* code = new std::string();
    if (declr->size() == 0) return code;
    vector<std::string> lines = split(*declr, ';'); //split declr into lines
    for (int j = 0; j < lines.size(); j++) {
        if (lines.at(j).size() == 0) break;
        int colenPos = lines.at(j).find(':');
        std::string typestr = lines.at(j).substr(colenPos + 1);
        int brackstart = typestr.find('[');
        int len = typestr.find(']') - brackstart - 1;
        std::string idline = lines.at(j).substr(0, colenPos);
        int type = (typestr.at(0) == 'i') ? 0 : 1;
        std::vector<std::string> ids = split(idline, ',');
        for (int i = 0; i < ids.size(); i++) {
            if (symbols.find(ids.at(i)) != symbols.end()) {
                cerr << BOLDBLACK << exec_name << ':' << yylineno << ':' << charNo << ':' 
                    << BOLDRED << " fatal: " << RESET;
                std::cerr << "Redeclaration of symbol " << ids.at(i) << std::endl;
                exit(1);
            }
            symbols[ids.at(i)] = type;
            if (type == 0) *code = *code + ". " + ids.at(i) + "\n";
            else *code = *code + ".[] " + ids.at(i) + ", " + typestr.substr(brackstart + 1, len) + "\n";
        }
    }
    return code;
}


std::string* paramCode(std::string* declr) { //generate declaration statements for parameters
    std::string* code = new std::string();
    int paramCount = 0;
    if (declr->size() == 0) return code;
    vector<std::string> lines = split(*declr, ';'); //split declr into lines
    for (int j = 0; j < lines.size(); j++) {
        if (lines.at(j).size() == 0) break;
        int colenPos = lines.at(j).find(':');
        std::string typestr = lines.at(j).substr(colenPos + 1);
        int brackstart = typestr.find('[');
        int len = typestr.find(']') - brackstart - 1;
        std::string idline = lines.at(j).substr(0, colenPos);
        int type = (typestr.at(0) == 'i') ? 0 : 1;
        std::vector<std::string> ids = split(idline, ',');
        for (int i = 0; i < ids.size(); i++) {
            if (symbols.find(ids.at(i)) != symbols.end()) {
                cerr << BOLDBLACK << exec_name << ':' << yylineno << ':' << charNo << ':' 
                    << BOLDRED << " fatal: " << RESET;
                std::cerr << "Redeclaration of symbol " << ids.at(i) << std::endl;
                exit(1);
            }
            symbols[ids.at(i)] = type;
            *code = *code + ". " + ids.at(i) + "\n"; //code can only be integers in params
            std::ostringstream strout;
            strout << paramCount;
            *code = *code + "= " + ids.at(i) + ", $" + strout.str(); //initialize to the proper parameter
            paramCount++;
        }
    }
    return code;
}


void takeOutTheTrash(int n, ...) { //USAGE: n is the number of pointers to delete, then just list the pointers
    va_list args;

    va_start(args, n);
    for (int i = 0; i < n; i++) {
        void* m = va_arg(args, void*);
        if (m != 0) delete m; //assume m is not dangling bc if so seg fault
    }
    va_end(args);
}
