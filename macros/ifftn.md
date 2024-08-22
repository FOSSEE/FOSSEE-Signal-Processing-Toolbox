# ifftn
## Description
Compute the inverse N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm.

The optional vector argument SIZE may be used specify the dimensions of the matrix to be used.
If an element of SIZE is smaller than the corresponding dimension of A, then the dimension of A is truncated prior to performing the inverse FFT.

Otherwise, if an element of SIZE is larger than the corresponding dimension then A is resized and padded with zeros.

## Calling Sequence

- `ifftn(A)`
- `ifftn(A,size)`
## Parameters
- `A` : input matrix
- `size` :(optional) dimensions of the
array to be used. 
## Examples
1.
```scilab
A=[1:5;6:10];A(:,:,2)=[3:7;9:13];
ifftn(A)
```
```output
 ans  =

(:,:,1)

   6.75 + 0.i  -0.5 - 0.688191i  -0.5 - 0.1624598i  -0.5 + 0.1624598i  -0.5 + 0.688191i
  -2.75 + 0.i   0.  + 0.i         0.  + 0.i          0.  + 0.i          0.  + 0.i      
(:,:,2)

  -1.25 + 0.i   0. + 0.i   0. + 0.i   0. + 0.i   0. + 0.i
   0.25 + 0.i   0. + 0.i   0. + 0.i   0. + 0.i   0. + 0.i

```
2.
```scilab
A=[1 2 9: 0 1 2];
ifftn(A,[1 2])
```
```output
ans  =

   1.5  -0.5
```
3.
```scilab
 a=[1:5;6:10];a(:,:,2)=[3:7;9:13];
 ifftn(a)
 ```
 ``` 
  ans  =

(:,:,1)

   6.75 + 0.i  -0.5 - 0.688191i  -0.5 - 0.1624598i  -0.5 + 0.1624598i  -0.5 + 0.688191i
  -2.75 + 0.i   0.  + 0.i         0.  + 0.i          0.  + 0.i          0.  + 0.i      
(:,:,2)

  -1.25 + 0.i   0. + 0.i   0. + 0.i   0. + 0.i   0. + 0.i
   0.25 + 0.i   0. + 0.i   0. + 0.i   0. + 0.i   0. + 0.i

```
4.
```
ifftn([99 45 67;32 12 356;887 546 321],[2 3])
```
```
 ans  =

   101.83333 + 0.i  -18.166667 - 52.82755i   -18.166667 + 52.82755i 
  -31.5      + 0.i   32.5      + 46.476697i   32.5      - 46.476697i
  ```

5.
```
ifftn([1 1 1 ;0 0 0;111 111 111 ;0 0 0;11 11 11],[2 1])
```
```output
ans =

   0.50000
   0.50000
   ```

