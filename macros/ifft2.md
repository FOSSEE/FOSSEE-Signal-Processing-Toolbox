#  ifft2

## Description
 Calculates the inverse two-dimensional discrete Fourier transform of A using a Fast Fourier Transform algorithm.

 It performs inverse two-dimensional FFT on the matrix A. m and n may be used specify the number of rows and columns of A to use. If either of these is larger
 than the size of A, A is resized and padded with zeros.

 If A is a multi-dimensional matrix, each two-dimensional sub-matrix of A is treated separately.
## Calling Sequence
- `ifft2 (A)`
- `ifft2 (A, m, n)`

## Parameters
- `A` : Input matrix for which the inverse two-dimensional discrete Fourier transform is to be calculated.
- `m,n`: The optional arguments m and n may be used specify the number of rows and columns of A to use. If either of these is larger than the size of A, A is resized and padded with zeros.

## Examples:
1.
```scilab
A=[88 66 34;999 333 234];
ifft2(A);
```
```output
ans  =

   292.33333 + 0.i   125.58333 + 18.908221i   125.58333 - 18.908221i
  -229.66667 + 0.i  -112.91667 - 9.670617i   -112.91667 + 9.670617i 
```
2.
```scilab
A=[567 89 388; 93 4 80];
m=1;
n=4;
ifft2(A,m,n);
```
```output
ans  =

   261. + 0.i   44.75 + 22.25i   216.5 + 0.i   44.75 - 22.25i
```
3.
```
a=[1 2 3;4 5 6;7 8 9];a(:,:,2)=[1 2 3;4 5 6;9 10 11];
ifft2(a);

```
```
ans  =

(:,:,1)

   5.  + 0.i         -0.5       - 0.2886751i  -0.5       + 0.2886751i
  -1.5 - 0.8660254i  -2.862D-17 - 1.388D-17i   1.396D-16 + 1.388D-17i
  -1.5 + 0.8660254i   1.396D-16 - 1.388D-17i  -2.862D-17 + 1.388D-17i
(:,:,2)

         column 1 to 2

   5.6666667 + 0.i         -0.5       - 0.2886751i
  -1.8333333 - 1.4433757i   1.660D-17 - 2.894D-16i
  -1.8333333 + 1.4433757i  -1.276D-16 + 9.515D-17i

         column 3

  -0.5       + 0.2886751i
  -1.276D-16 - 9.515D-17i
   1.660D-17 + 2.894D-16i
  ```
4.
```
ifft2([132 7 8 9; 93 80 7 8 ;0 1 2 5],1,4)
```
```
 ans  =

   39. + 0.i   31. - 0.5i   31. + 0.i   31. + 0.5i
 ```
5.
```
ifft2([567 89 43 88; 973 457 897 0])
```
```
 ans  =

   39. + 0.i   31. - 0.5i   31. + 0.i   31. + 0.5i
   ```




