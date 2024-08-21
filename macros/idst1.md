# idst1
## Description
Computes the inverse type I discrete sine transform of x.
If x is a matrix, compute the transform along the columns of the the matrix.

## Calling Sequence

- `idst1(x)`

- `idst1(x,n) `
## Parameters
- `x` : A vector or Matrix
- `n` :  If n is given, then x is padded or trimmed to length n before computing the transform.

## Examples
1. 
```scilab
idst1([87 65;87 54;32 64])
```
```output
ans  =

   85.572853   72.608387
   27.5        0.5      
  -1.4271465   18.608387

```
2.
```scilab
idst1([1 2 3;4 5 6;7 8 9],2)
```
```output
ans  =

   4.6188022   5.7735027   6.9282032
  -3.4641016  -3.4641016  -3.4641016
   0.          0.          0.      

```
3.
```scilab
idst1([45 87 65 43;98 65 43 23;0 4 3 2],3)
```
```output
ans  =

   64.909903   64.673359   45.541631   27.409903
   22.5        41.5        31.         20.5     
  -33.090097  -0.3266415   2.5416306   4.4099026

```
4.
```scilab
idst1([12;56;78;78;99],2)
```
```output
 ans  =

   166.36494
  -62.931179
   22.
  -37.527767
   11.635064

```
5.
```scilab
idst1([15 67 89 54 23 89],3)
```
```output
ans  =

   127.45172   0.1136147   14.320069  -59.299826   27.806168  -16.192752

```
