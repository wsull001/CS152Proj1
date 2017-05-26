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

inline std::string itoa( int x ) {  // converts an integer to a string.
  ostringstream s;
  s << x;
  return s.str();
}


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



#endif //WHY_NO_GUARDS_BUT_STDS
