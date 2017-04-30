//Program to turn our rules (that are in c++) into valid LaTeX
//Too lazy to use file i/o, so pipe the file into the program
//-Stanley

#include <iostream>
#include <vector>

using namespace std;

//Code borrowed from: http://stackoverflow.com/questions/1798112
std::string trim(const std::string& str,
                 const std::string& whitespace = " \t")
{
    const auto strBegin = str.find_first_not_of(whitespace);
    if (strBegin == std::string::npos)
        return ""; // no content
    
    const auto strEnd = str.find_last_not_of(whitespace);
    const auto strRange = strEnd - strBegin + 1;
    
    return str.substr(strBegin, strRange);
}

int main() {
    string line;
    while(getline(cin, line)) {
        line = trim(line);
        if(line == "" || line == "END") continue;
        
        string name = line.substr(0, line.find(':'));
        
        int start_pos = 0;
        while((start_pos = name.find("_", start_pos)) != string::npos) {
            name.replace(start_pos, 1, "\\_");
            start_pos += 2; //length of \_
        }
        
        cout << endl << "{\\vskip 0.1in \\noindent\\bf " << name
            << "} $\\Rightarrow$ " << endl;
        
        string transition = trim(line.substr(line.find(':') + 1,
                                            line.find('{')-line.find(':')-1));
        
        start_pos = 0;
        while((start_pos = transition.find("_", start_pos)) != string::npos) {
            transition.replace(start_pos, 1, "\\char`_");
            start_pos += 7; //length of \char`_
        }
        cout << "\t" << transition;
        while(getline(cin, line)) {
            line = trim(line);
            if(line == ";") break;
            
            transition = trim(line.substr(line.find('|') + 1,
                                          line.find('{')-line.find('|')-1));
            if(transition == "") {
                cout << " $|$ $\\epsilon$";
            } else {
                start_pos = 0;
                while((start_pos = transition.find("_", start_pos)) != string::npos) {
                    transition.replace(start_pos, 1, "\\char`_");
                    start_pos += 7; //length of \char`_
                }
                cout << " $|$ " << transition;
            }
        }
    }
    
    cout << endl << endl;
    
    return 0;
}
