# idct2
## Description
Compute the inverse 2-D discrete cosine transform of matrix x.

## Calling Sequence

- `idct2(x)`

- `idct2(x,m,n)`
- `idct2(x,[m,n])`
## Parameters
- `x` : A Matrix
- `[m,n]` : zero-pads or crops the matrix A to size m-by-n before applying the inverse transformation.
## Dependencies
idct1
## Examples
1. 
```scilab
idct2([1 2 3;4 5 6;7 8 9])
```
```output
ans  =

   13.181298  -4.2620729   1.9295022
  -9.0616971   1.6192881  -1.457086 
   1.4512096  -0.599856    0.1994143

```
2. 
```scilab
idct2([87 43 56;98 76 54],2,4)
```
```output
 ans  =

   159.26908   49.286169   3.7468401   49.327418
  -18.425993  -10.910471   1.7180826   12.062032

```
3. 
```scilab
idct2([12;24;54;67;43],[5,5])
```
```output
ans =

    2.0271
   11.0753
   38.4167
   59.6603
   69.3688

```
4. 
```scilab
idct2([87 65 43 21],[5,5])
```
```output
ans =

   89.283   42.976   49.666   34.545   24.608

```
5.
```scilab
idct2([11 22 33;44 55 66;77 88 99],[2,2])
//verify with MATLAB's idct2 because Octave's idct2 doesn't support croping of matrix
```
```output
ans  =

   66.  -11.      
  -33.   3.553D-15

```
