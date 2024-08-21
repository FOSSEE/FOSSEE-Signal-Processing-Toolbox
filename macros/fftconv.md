## fftconv
## Description
Convolve two vectors using the FFT for computation
## Calling Sequence
- `fftconv(x,y)`
- `fftconv(x,y,n)`
## fftconv
## Description
Convolve two vectors using the FFT for computation
## Calling Sequence
- `fftconv(x,y)`
- `fftconv(x,y,n)`

## Parameters
`x` : A Vector 

`y` : A Vector

`n` : (optional) 

## Details
c = fftconv (x, y) returns a vector of length equal to length (x) + length (y) - 1. 
If x and y are the coefficient vectors of two polynomials, 
the returned value is the coefficient vector of the product polynomial.

If the optional argument n is specified, an N-point FFT is used.
## Examples
1.
```scilab
fftconv([1 2 3],[4  5 6]);
```
```output
 ans  =

   4.   13.   28.   27.   18.
```
2.
```scilab
fftconv([%i %pi 2],[%pi %i],1);
```
```output
ans  =

         column 1 to 3

   0. + 3.1415927i   8.8696044 + 3.140D-16i   6.2831853 + 3.1415927i

         column 4

   0. + 2.i
```
3.
```scilab
fftconv([9 8 65 43 21 90],[ 122 87 65]);
```
```output
ans  =

   1098.   1759.   9211.   11421.   10528.   15602.   9195.   5850.
```
4.
```scilab
fftconv([25:30],[89:94],1);
```
```output
ans  =

         column 1 to 9

   2225.   4564.   7018.   9588.   12275.   15080.   12870.   10540.   8089.

         column 10 to 11

   5516.   2820.
```
5.
```scilab
fftconv([1 2 3 4 5*%i 2+%pi],[87 64 53 %i 0 0 ],2);
```

```output
ans  =

         column 1 to 4

   87. + 1.421D-14i   238. - 2.842D-14i   442. + 3.847D-14i   646. + 1.i

         column 5 to 7

   415. + 437.i   659.31856 + 323.i   329.06193 + 269.i

         column 8 to 10

   267.50441 - 2.337D-14i   1.421D-14 + 5.1415927i   1.421D-14 + 2.842D-14i

         column 11

  -2.842D-14 + 1.837D-14i
```  

