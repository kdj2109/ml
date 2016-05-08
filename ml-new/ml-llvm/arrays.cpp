// Use clang -S -emit-llvm arrays.c to compile to llvm
#include <iostream>
using namespace std;

int addTuples(int a[]);

int addTuples(int a[])
{
  return a[0];
}

int main ()
{
   // an int array with 5 elements.
   int balance[5] = {1000, 2, 3, 17, 50};
   // pass pointer to the array as an argument.
   int x = addTuples( balance );

   cout << x << '\n';

   return 0;
}
