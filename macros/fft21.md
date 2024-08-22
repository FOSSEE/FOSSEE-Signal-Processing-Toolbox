# Function: fft21
## Description
Compute the two-dimensional discrete Fourier transform of a Matrix using the Fast Fourier Transform (FFT) algorithm.

## Calling Sequence:
- `fft21(A)`
- `fft21(A,m,n)`
## Parameters 
-`A` : Input Matrix

-`m` : number of rows of A to be used 

-`n` : number of columns of A to be used

 You can use the variables m and n to specify the number of rows and columns of A that you want to use. If either of these variables is larger than the size of A, then A will be resized, and zeros will be added as padding. If A is a multi-dimensional matrix, the function will treat each two-dimensional sub-matrix of A separately.

## Examples
1.
```scilab
A=[500 3000;200 4000];
fft21(A);
```
```output
ans  =

   7700.  -6300.
  -700.    1300.
```
2.
```scilab
A=[12 67 48;89 2 1;965 4 231;56 32 19];
m=2;
n=2;
fft21(A,m,n);
```
```output
 ans  =

   170.   32. 
  -12.   -142.
```
3.
```scilab
fft21([1 2 3;7 8 9;2 3 1]);
```
```output
 ans  =

   36. + 0.i         -3.  + 0.i         -3.  + 0.i       
  -9.  - 15.588457i   1.5 + 2.5980762i  -3.  + 0.i       
  -9.  + 15.588457i  -3.  + 0.i          1.5 - 2.5980762i
```
4.
```scilab
 a=[2*%pi+%i 2+3*%i 4+0.5*%i;1 0 1; %i %pi %i];
 fft21(a,4,4);
 ```
 ```output
 ans  =

   17.424778 + 6.5i   5.2831853 - 4.6415927i   7.1415927 + 0.5i  -0.7168147 + 5.6415927i
   9.1415927 + 0.5i   5.2831853 + 1.6415927i   11.424778 - 5.5i  -0.7168147 - 0.6415927i
   13.424778 + 6.5i   5.2831853 - 4.6415927i   3.1415927 + 0.5i  -0.7168147 + 5.6415927i
   9.1415927 + 4.5i   5.2831853 + 1.6415927i   11.424778 - 1.5i  -0.7168147 - 0.6415927i
```
5.
```scilab
a=[8 9 6 ;3 5 6;87 54 23];a(:,:,2)=[88 43 25;98 54 32;97 56 43];
fft21(a,2,2);
```
```output
 ans  =

(:,:,1)

   25.  -3.
   9.    1.
(:,:,2)

   283.   89.
  -21.    1. 
```
