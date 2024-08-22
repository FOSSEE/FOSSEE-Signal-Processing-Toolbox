# idct1
### Compute the inverse discrete cosine transform of x.
## Calling Sequence
- `idct(x)`
- `idct1(x,n)`
## Parameters
-`x` : A matrix or an Integer

-`n` (optional) : If n is given, then x is padded or trimmed to length n before computing the transform. 
If x is a matrix, compute the transform along the columns of the the matrix

The inverse discrete cosine transform x can be defined as follows:


<p style="white-space: nowrap; font-size: 30px;">
    x[n] = Σ<sub>k=0</sub><sup>N-1</sup> w(k) X[k] cos(<span style="font-size: 16px;">π(2n+1)k/2N</span>), &nbsp; n = 0, ..., N-1
</p>
<p style="font-size: 16px;">with w(0) = √(1/N) and w(k) = √(2/N), k = 1, ..., N-1</p>

##  Examples
1.
```scilab
a=[1 4 6];
idct1(a)
```
```output
ans  =


   5.8552671  -4.3216292   0.1984129
```
2.
```scilab
idct1([1 2;4 5;87 66;9 32],4)
```
```output
 ans  =
                                                                                                    
   49.049   45.926
  -47.797  -51.552
  -38.203  -12.448
   38.951   22.074
```
3.
```scilab
idct1([11 23 45 67;87 65 43 58;65 43 21 36],5)
```
```output
 ans  =

   90.508305   71.385168   56.734166   83.270388
   24.557861   26.045636   32.005548   44.488875
  -36.19026   -16.909675   6.8430456   7.1949117
  -40.126297  -22.281608   0.0352167   1.3661026
  -14.152861  -6.8099566   5.0050835   13.496277
```
4.
```scilab
idct1([1 2 3;4 5 6;7 8 9],2);//truncating example 
This operation is not supported by Octave
You can verify with  Matlab's function
```
```output
ans  =

   3.5355339   4.9497475   6.363961 
  -2.1213203  -2.1213203  -2.1213203
```
5.
```scilab
a=[1 2 3;4 5 6];a(:,:,2)=[1 4 6;7 8 9];
// Multidim operation is also not supported by Octave. You can verify it with Matlab's function.
idct1(a)
```
```output
 ans  =

(:,:,1)

   3.5355339   4.9497475   6.363961 
  -2.1213203  -2.1213203  -2.1213203
(:,:,2)

   5.6568542   8.4852814   10.606602
  -4.2426407  -2.8284271  -2.1213203
```