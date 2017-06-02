// -*- c++ -*- 
// heading.H

#ifndef WHY_NO_GUARDS_BUT_STDS
#define WHY_NO_GUARDS_BUT_STDS

using namespace std;

// The following line suppresses an unused-function warning.
#define YY_NO_UNPUT

#include <iostream>
#include <set>
#include <string>
#include <map>
#include <list>
#include <vector>
#include <sstream>
#include <cassert>
#include <cctype>
#include <cstring>
#include <stack>

//the following are UBUNTU/LINUX ONLY terminal color codes.
#define RESET   "\033[0m"
#define BLACK   "\033[30m"      /* Black */
#define RED     "\033[31m"      /* Red */
#define GREEN   "\033[32m"      /* Green */
#define YELLOW  "\033[33m"      /* Yellow */
#define BLUE    "\033[34m"      /* Blue */
#define MAGENTA "\033[35m"      /* Magenta */
#define CYAN    "\033[36m"      /* Cyan */
#define WHITE   "\033[37m"      /* White */
#define BOLDBLACK   "\033[1m\033[30m"      /* Bold Black */
#define BOLDRED     "\033[1m\033[31m"      /* Bold Red */
#define BOLDGREEN   "\033[1m\033[32m"      /* Bold Green */
#define BOLDYELLOW  "\033[1m\033[33m"      /* Bold Yellow */
#define BOLDBLUE    "\033[1m\033[34m"      /* Bold Blue */
#define BOLDMAGENTA "\033[1m\033[35m"      /* Bold Magenta */
#define BOLDCYAN    "\033[1m\033[36m"      /* Bold Cyan */
#define BOLDWHITE   "\033[1m\033[37m"      /* Bold White */

inline std::string itoa( int x ) {  // converts an integer to a string.
  ostringstream s;
  s << x;
  return s.str();
}

// These should create a name and install it into the appropriate table.
// It's attributes can be filled in later.

inline std::string newVar()   {
  static int counter = 0;
  return "Var" + itoa(counter++);
}

inline std::string newArry()  {
  static int counter = 0;
  return "Arry" + itoa(counter++);
}

inline std::string newParam() {
  static int counter = 0;
  return "Param" + itoa(counter++);
}

inline std::string newFunct() {
  static int counter = 0;
  return "Funct" + itoa(counter++);
}

inline std::string newTemp(ostringstream &code)  {
  static int counter = 0;
  string temp = "__Temp__" + itoa(counter++);
  code << ". " << temp << endl;
  return temp;
}

inline std::string newLabel() {
  static int counter = 0;
  return "Label" + itoa(counter++);
}



#endif //WHY_NO_GUARDS_BUT_STDS
