# fftn: N-Dimensional Fast Fourier Transform
Computes the N-dimensional discrete Fourier transform (DFT) 
of an input array using a Fast Fourier Transform (FFT) algorithm.

## Syntax
-`Y=fftn(A)`

-`Y = fftn(A, size)`
### Parameters:

-`A` : The input array for which the Fourier transform is to be computed.

-`size` (optional): A vector specifying the desired dimensions of the output array Y.
- ```Y = fftn(A)```

- ```Y = fftn(A, size)```
### Parameters:

- ```A``` : The input array for which the Fourier transform is to be computed.

- ```size``` (optional): A vector specifying the desired dimensions of the output array Y.

### Details
`fftn(A)` computes the N-dimensional DFT along each dimension of the input array A.

`fftn(A, size)` allows you to specify the desired output size before computing the DFT.

If any element in size is smaller than the corresponding dimension of A, that dimension will be truncated before the FFT.

Conversely, if any element in size is larger, A will be resized and padded with zeros to match the specified size.
### Usage
Example 1: 
```scilab
fftn([3 7 5;0 1 7;9 5 4]);
```
```output
 ans  =

         column 1

   41. + 0.i      
   2.  + 8.660254i
   2.  - 8.660254i

         column 2

  -2.5 + 2.5980762i
   2.  + 3.4641016i
  -8.5 - 11.25833i 

         column 3

  -2.5 - 2.5980762i
  -8.5 + 11.25833i 
   2.  - 3.4641016i


```


Example 2: 
```scilab
fftn([100 278;334 985]);
```
```output
 ans  =

   1697.  -829.
  -941.    473.
```
3.
```scilab
 fftn([2:5;8 7 5 1;7 3 4 5;0 0 1 6],[2 2]);
 ```
 ```output
 ans  =

   20.   0.
  -10.  -2.
  ```
  4.
  ```scilab
 a=[%i 2+3*%i 2+%pi;%pi %i+2 %pi+%i;1 5+2*5*%i %pi+10*%i]
 fftn(a,[2 2]);
 ```
 ```output
 ans  =

   7.1415927 + 5.i  -0.8584073 - 3.i
  -3.1415927 + 3.i  -3.1415927 - i   
```
5.
```scilab
 fftn([2:5;8 7 5 1;7 3 4 5;0 0 1 6],[2]);
 ```
```output 
Error
Output size must have at least Ndims
```
