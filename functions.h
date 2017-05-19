//functions for proj2.y
//headers in this file

//includes
#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <map>
#include <stdlib.h>

//functions

std::map<std::string, int> symbols; //0 for int, 1 for array, 2 for function


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

std::string* declrCode(std::string* declr) { //generate declaration statements
        std::string* code = new std::string();
        int colenPos = declr->find(':');
        std::string typestr = declr->substr(colenPos + 1);
        std::cout << *declr << std::endl;
        int brackstart = typestr.find('[');
        int len = typestr.find(']') - brackstart;
        std::string idline = declr->substr(0, colenPos);
        int type = (typestr.at(0) == 'i') ? 0 : 1;
        std::vector<std::string> ids = split(idline, ',');
        for (int i = 0; i < ids.size(); i++) {
                if (symbols.find(ids.at(i)) != symbols.end()) {
                        std::cerr << "Redeclaration of symbol " << ids.at(i) << std::endl;
                        exit(1);
                }
                symbols[ids.at(i)] = type;
                if (type == 0) *code = *code + ". " + ids.at(i) + "\n";
                else *code = *code + ".[] " + ids.at(i) + ", " + typestr.substr(brackstart + 1, len) + "\n";
        }
        return code;
}
