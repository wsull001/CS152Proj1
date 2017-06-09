# Compile\_of\_Crap (CS152Proj1 <sub><sup>(±2)</sub></sup>)
### With Preston, Wyatt and now Stanley! <sub><sup><sub><sup> Though apparently he's not needed... </sub></sup></sub></sup>

#### Overview

The compile\_of\_crap is the first custom compiler built by the 
Wyatt-Preston-Stanley team. Get it while it's hot!

#### Language Accepted

The compile\_of\_crap was built to compile 
[MINI-L](http://www.cs.ucr.edu/~gupta/teaching/152-17/Project-Phase-I/mini_l.html) 
code to [mil](http://www.cs.ucr.edu/~gupta/teaching/152-17/Project-Phase-III/code_output_format.html).

We used [Flex](http://alumni.cs.ucr.edu/~lgao/teaching/flex.html)
 as a lexical analyzer and [Bison](http://alumni.cs.ucr.edu/~lgao/teaching/bison.html)
 for generating an LALR(1) bottom-up parser.

#### Compiling the Crap

Run `git clone https://github.com/wsull001/CS152Proj1.git` to clone the repo, 
and then `make` to build the project. Once the project is built, 
you can compile your MINI-L code with the following:

`./compile_of_crap your_code.min > run_me.mil`

#### Running the Crap

The mil interpereter can be found 
[here](http://www.cs.ucr.edu/~gupta/teaching/152-17/Project-Phase-III/mil_run).
Download the interpereter and modify the permissions so that it will be executable.
Then run the output of the compiler (`run_me.mil`) through the interpereter!

#### Thanks

Special thanks to mom for getting me here.
