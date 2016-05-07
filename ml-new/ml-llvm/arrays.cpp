// Use clang -S -emit-llvm arrays.c to compile to llvm

int getAverage(int arr[], int size);

int getAverage(int arr[], int size)
{
  return arr[0];
}

int main ()
{
   // an int array with 5 elements.
   int balance[5] = {1000, 2, 3, 17, 50};
   // pass pointer to the array as an argument.
   int x = getAverage( balance, 5 ) ;

   return 0;
}
