# cplxreal
## Description  
Sort the numbers z into complex-conjugate-valued  ( zc )and real-valued elements ( zr ).
The positive imaginary complex numbers of each complex conjugate pair are returned in zc and the real numbers are returned in zr.

tol is a weighting factor in the range [0, 1) which determines the tolerance of the matching.
The default value is 100 * eps and the resulting tolerance for a given complex pair is tol * abs (z(i))).
By default the complex pairs are sorted along the first non-singleton dimension of z. If dim is specified, then the complex pairs are sorted along this dimension.

Signal an error if some complex numbers could not be paired.
Signal an error if all complex numbers are not exact conjugates (to within tol).
Note that there is no defined order for pairs with identical real parts but differing imaginary parts.

## Calling Sequence

- `[zc, zr] = cplxreal (z) `
- `[zc, zr] = cplxreal (z, tol)`
- `[zc, zr] = cplxreal (z, tol, dim)`

## Parameters
### INPUTS
- ` z ` :  A vector of numbers or Matrix
- ` tol ` : tol is a weighting factor in the range [0, 1) which determines the tolerance of the matching. Default value 100 * eps.
- ` dim ` : If dim is specified, then the complex pairs are sorted along this dimension.
### OUTPUTS
- `zc` : complex conjugate pair
- `zr` :  real numbers


## Dependencies: 
ipermute , cplxreal
## Examples
1. 
```scilab
   [zc, zr] = cplxreal ([])
```
```output

zc  = 

    []
 zr  = 

    []
    ```

2.
```scilab
 [zc, zr] = cplxreal (1)
```
```output
 zc  = 

    []
 zr  = 

   1.


```
3.
```scilab
[zc, zr] = cplxreal ([1+1*%i, 1-1*%i])
```
```output
zc  = 

   1. + i  
 zr  = 

    []
```
4.
```scilab
[zc, zr] = cplxreal (roots ([1, 0, 0, 1]))

```
```output
 zc  = 

   0.5 + 0.8660254i
 zr  = 

  -1.

```
5.
```scilab

 [zc, zr] = cplxreal ([roots([1,0,0,1,0,0])' roots([0,0,1,1,1,0])'])
```
```output

 zc  = 

  -0.5 + 0.8660254i   0.5 + 0.8660254i
 zr  = 

  -1.   0.   0.   0.


```
