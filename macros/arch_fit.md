#  arch_fit
## Calling Sequence

- ` [a, b] = arch_fit (y, x, p) `
- ` [a, b] = arch_fit (y, x, p, iter, gamma, a0, b0) `

## Description
Fit an ARCH regression model to the time series y using the scoring algorithm in Engle’s original ARCH paper.

The model is

y(t) = b(1) * x(t,1) + … + b(k) * x(t,k) + e(t),
h(t) = a(1) + a(2) * e(t-1)^2 + … + a(p+1) * e(t-p)^2
in which e(t) is N(0, h(t)), given a time-series vector y up to time t-1 and a matrix of (ordinary) regressors x up to t. The order of the regression of the residual variance is specified by p.

If invoked as arch_fit (y, k, p) with a positive integer k, fit an ARCH(k, p) process, i.e., do the above with the t-th row of x given by

[1, y(t-1), …, y(t-k)]
Optionally, one can specify the number of iterations iter, the updating factor gamma, and initial values a0 and b0 for the scoring algorithm.
##  Parameters
- `y`(vector) :  A time-series data vector up to time t-1 .
- `x` (Matrix):  A matrix of (ordinary) regressors x up to t.
- `p` (scalar):  The order of the regression of the residual variance.
- `iter` (scaler) : Number of iterations
- `gamma` (real number) : updating factor
- `a0 b0` (real numbers) : Initial values for the scoring algorithm
## Dependencies: 
ols autoreg_matrix


## Examples
1. 
```scilab
t = linspace(0,10,1000);

y = cos(t);

x = sin(t);

[a,b] = arch_fit(y,x',1)

```
```output
 pval  = 

   0.0175825
   0.9357096
 lm  = 

   0.0242719

  ```

2.
```scilab
t = linspace(0,10,1000);
y = sin(t);
x = [ zeros(1,300) ones(1,400) zeros(1,300);zeros(1,200) ones(1,200) zeros(1,600);zeros(1,100) ones(1,400) zeros(1,500)];
[a,b] = arch_fit(y,x',3)
```
```output
 a  = 

   0.0020139
   1.0353154
  -0.0009762
  -0.0334181
 b  = 

  -0.7849689
   0.2267450
   0.3037736
```
3.
```scilab
 t = linspace(-10,10,2000);
y = exp(t);
x = [sin(t);cos(t);tan(t)];
[a,b] = arch_fit(y,x',5)

```
```output
a  = 

   69311.100
   0.8883086
   0.3352075
   0.1473639
  -0.0385322
  -0.3485546
 b  = 

   334.06505
  -1464.5987
  -0.5365645
```
4.
```scilab
 t = linspace(-10,10,2000);
y = exp(t);
x = [sin(t);cos(t);tan(t)];
 [a,b] = arch_fit(y,x',5,1000,0.32,[1;0;1;0;1;0],[1;0;1]);
 a,b
```
```output
 a  = 

   0.0001950
   1.1362016
  -0.1143480
   0.0180131
  -0.0284946
   0.0200169
 b  = 

   1.
  -6.465D-22
   1.

```
5.
```scilab

t= linspace(0,100,100);

y = t .* t + 2*t + 3;

 x = 3;

[a,b] = arch_fit(y,x,1,1000,0.2,[1 ;1],[0; 0 ;0 ;0])
```
```output
//Octave will return Nan vectors which means no solution  

inv: Problem is singular. // implies no solution
```
