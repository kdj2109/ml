#!/bin/sh
inter=$x;

# Regression testing script for MicroC
# Step through a list of files
#  Compile, run, and check the output of each expected-to-work test
#  Compile and check the error of each expected-to-fail test

# Path to the LLVM interpreter
LLI="lli"
#LLI="/usr/local/opt/llvm/bin/lli"

#Path to the LLVM compiler
LLC="llc"
#LLC="/usr/local/opt/llvm/bin/llc"

#Path to the G++ compiler
GPP="g++"

# Path to the ml compiler.  Usually "./ml.native"
# Try "_build/ml.native" if ocamlbuild was unable to create a symbolic link.
ML="./ml.native"
#ML="_build/ml.native"

# Run <args>
# Report the command, run it, and report any errors
Run() {
    echo $* 1>&2
    eval $* || {
	SignalError "$1 failed on $*"
	return 1
    }
}

    Run "$ML"  "demo.mxl" ">" "demo.ll" &&
    Run "$LLC" "-filetype=obj" "demo.ll" ">" "demo.o" &&
    Run "$GPP" "demo.o" ">" "a.out" &&
    Run "./a.out" ">" "demo.ppm"