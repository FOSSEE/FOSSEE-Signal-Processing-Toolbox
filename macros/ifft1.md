# ifft1
## Description
Compute the inverse discrete Fourier transform of x using a Fast Fourier Transform (FFT) algorithm.
The inverse FFT is calculated along the first non-singleton dimension of the array.
 ## Parameters
`x` : input matrix

`n` : Specifies the number of elements of x to be used

`dim` : Specifies the dimention of the matrix along which the inverse FFT is performed

## Calling Sequence
- `ifft1(x)` :   
- `ifft1(x,n)`:
- `ifft1(x,n,dim)`

    
 fft (x) computes the inverse FFT for each column of x.
 
 If called with two arguments, n is expected to be an integer specifying the number
 of elements of x to use, or an empty matrix to specify that its value should be ignored. 
 If n is larger than the dimension along which the inverse FFT is calculated, then x is resized and padded with zeros.
 Otherwise, if n is smaller than the dimension along which the inverse FFT is calculated, then x is truncated.
 
 If called with three arguments, dim is an integer specifying the dimension of the matrix along which the inverse FFT is performed
## Examples
1.
```scilab
ifft1([1:5])
```
```output
ans  =

         column 1 to 4

   3. + 0.i  -0.5 - 0.688191i  -0.5 - 0.1624598i  -0.5 + 0.1624598i

         column 5

  -0.5 + 0.688191i
```
2.
```scilab
ifft1([9; 8; 65; 43; 21 ;90])
```
```output

 ans  =

   39.333333 + 0.i       
  -4.6666667 - 5.4848276i
  -6.6666667 - 18.186533i
  -7.6666667 + 0.i       
  -6.6666667 + 18.186533i
  -4.6666667 + 5.4848276i
```
3.
```scilab
ifft1([88 43 78 55 ;998  32 77221 31221;321 122 44 281;8 12 12 1],4)
```
```output
 ans  =

   353.75 + 0.i      52.25 + 0.i   19338.75 + 0.i         7889.5 + 0.i   
  -58.25  + 247.5i  -19.75 + 5.i   8.5      + 19302.25i  -56.5   + 7805.i
  -149.25 + 0.i      30.25 + 0.i  -19277.75 + 0.i        -7721.5 + 0.i   
  -58.25  - 247.5i  -19.75 - 5.i   8.5      - 19302.25i  -56.5   - 7805.i

```
4.
```scilab
ifft1([1 2 3 ;4 5*%i 6; 2+%pi 0 1],3,2)
```
```output
 ans  =

   2.        + 0.i         -0.5       - 0.2886751i  -0.5       + 0.2886751i
   3.3333333 + 1.6666667i  -1.1100423 - 2.5653841i   1.776709  + 0.8987175i
   2.0471976 + 0.i          1.5471976 - 0.2886751i   1.5471976 + 0.2886751i

```
5.
```scilab
x = [1 2 3; 4 5 6; 7 8 9]
n = 3
dim = 2
ifft1 (x, n, dim)
```
```output
ans =
    
        2.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i
        5.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i
        8.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i
```

 
