# unwrap2

## Description
The unwrap function adjusts radian phases in the input array x by adding or subtracting multiples of 
2π as necessary to remove phase jumps that exceed the specified tolerance tol. If tol is not provided, it defaults to 𝜋
- `Radian Phases`: These are typically angles or phases expressed in radians, commonly encountered in signal processing and communication systems.
- `Tolerance` (tol): Determines the maximum allowable discontinuity in the phases. 
If the difference between consecutive phases exceeds tol, unwrap adjusts the phase by adding or subtracting 2π.
- `Dimension` (dim): Specifies the dimension along which the unwrapping operation is applied. 
By default, unwrap operates along the first non-singleton dimension of the input array x.
## Calling Sequence

- `b = unwrap(x)`
- `b = unwrap(x, tol)`
- `b = unwrap(x, tol, dim)`

## Parameters
- `x` : Input array containing radian phases to be unwrapped.
- `tol` (optional): Tolerance parameter specifying the maximum jump allowed between consecutive phases before adding or subtracting 2π. Defaults to 𝜋
- `dim` (optional): Dimension along which to unwrap the phases. If unspecified, dim defaults to the first non-singleton dimension of the array x.
### Dependencies: 
ipermute
## Examples
```scilab
t = [];
r = [0:100];                         // original vector
w = r - 2*%pi*floor ((r+%pi)/(2*%pi));  // wrapped into [-pi,pi]
unwrap2 (w)
```
```output

1 2 3 4 5 ............... 100

```

```scilab
A = [%pi*(-4), %pi*(-2+1/6), %pi/4, %pi*(2+1/3), %pi*(4+1/2), %pi*(8+2/3), %pi*(16+1), %pi*(32+3/2), %pi*64];
unwrap2 (A, %pi);

```
```output
    column 1 to 6

  -12.566371  -12.042772  -11.780972  -11.519173  -10.995574  -10.471976

         column 7 to 9

  -9.424778  -7.8539816  -6.2831853
```
```scilab
A = [%pi*(-4); %pi*(2+1/3); %pi*(16+1)];
B = [%pi*(-2+1/6); %pi*(4+1/2); %pi*(32+3/2)];
C = [%pi/4; %pi*(8+2/3); %pi*64];
D = [%pi*(-2+1/6); %pi*(2+1/3); %pi*(8+2/3)];
F(:, :, 1) = [unwrap2(A), unwrap2(B), unwrap2(C), unwrap2(D)];
F(:, :, 2) = [unwrap2(A+B), unwrap2(B+C), unwrap2(C+D), unwrap2(D+A)];
unwrap2 (F);
```
```output
     ans  =

(:,:,1)

  -12.566371  -5.7595865   0.7853982  -5.7595865
  -11.519173  -4.712389    2.0943951  -5.2359878
  -9.424778   -7.8539816   0.         -4.1887902
(:,:,2)

  -18.325957  -4.9741884  -4.9741884  -18.325957
  -16.231562  -2.6179939  -3.1415927  -16.755161
  -17.27876   -1.5707963  -4.1887902  -19.896753

```

```scilab
unwrap2(ones(4,1), [], 1)

```
```output
    ans  =

   1.
   1.
   1.
   1.
```

Test trivial return for m = 1 and dim > nd
```scilab

unwrap2 (ones(4,1), [], 2)
```
```
 ans  =

   1.
   1.
   1.
   1.
```
Test empty input return
```
unwrap2 ([])
```
```
 ans  =

    []
```
 Test handling of non-finite values
```scilab
x = %pi * [-%inf, 0.5, -1, %nan, %inf, -0.5, 1];
unwrap2 (x)

```
```
 ans  =

  -Inf   1.5707963   3.1415927   Nan   Inf   4.712389   3.1415927
 ``` 
 
