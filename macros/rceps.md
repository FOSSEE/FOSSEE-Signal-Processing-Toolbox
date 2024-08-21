# rceps
## Description
Real cepstrum and minimum-phase reconstruction
If called with two output arguments,
the minimum phase reconstruction of the signal x is returned in ym.
## Calling Sequence
- `[y,ym] = rceps(x)`
## Parameters
# Input
- `x` : A vector or a Matirx
# Output
- `y` : Real cepstrum
- `ym` : Minimum-phase reconstruction

## Dependencies
 fft1 , ifft1
## Examples
1. 
```scilab
 [y, xm]= rceps([1:6]);
 plot(y,xm)
```
<span>
   <img src='testcase1.svg'>
</span>

2. 
```scilab
[y, xm]= rceps([54:90]);
plot(y,xm);
```

<span>
<img src='testcase2.svg'>
</span>

3. 
```scilab
[y, xm]= rceps([1:3;12:14])
```
```output
y =

   2.481422   2.552973   2.615554
   0.083527   0.155077   0.217659

xm =

   11.96755   12.90912   13.86294
    1.99806    3.98897    5.97335
    0.16687    0.61814    1.29748

```

4. comments if any
```scilab
 [y, xm]= rceps([1 23 3;4 5 6;7 8 9]);
plot(y,xm)
```
<span>
    <img src='testcase4.svg'>
</span>
5.

```scilab
[y, xm]= rceps([1 4;5 6;7 8;9 0])
plot(y,xm)

```
<span>
    <img src='testcase5.png'>
</span>
