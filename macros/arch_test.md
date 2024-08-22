# arch_test
## Description
Perform a Lagrange Multiplier (LM) test for conditional heteroscedasticity.

For a linear regression model

y = x * b + e
perform a Lagrange Multiplier (LM) test of the null hypothesis of no conditional heteroscedascity against the alternative of CH(p).

I.e., the model is

y(t) = b(1) * x(t,1) + … + b(k) * x(t,k) + e(t),
given y up to t-1 and x up to t, e(t) is N(0, h(t)) with

h(t) = v + a(1) * e(t-1)^2 + … + a(p) * e(t-p)^2,
and the null is a(1) == … == a(p) == 0.

If the second argument is a scalar integer, k, perform the same test in a linear autoregression model of order k, i.e., with

[1, y(t-1), …, y(t-k)]
as the t-th row of x.

Under the null, LM approximately has a chisquare distribution with p degrees of freedom and pval is the p-value (1 minus the CDF of this distribution at LM) of the test.

If no output argument is given, the p-value is displayed.
## Calling Sequence

- ` [pval, lm] = arch_test (y, x, p) `


## Parameters
- `y`: Array-like. Dependent variable of the regression model.
- `x`: Array-like. Independent variables of the regression model.
         If x is a scalar integer k, it represents the order of autoregression.
- `p` : Integer. Number of lagged squared residuals to include in the heteroscedasticity model.


Returns:
- `pval`: Float. p-value of the LM test.
- `lm`: Float. Lagrange Multiplier test statistic.


## Dependencies: 
ols , autoreg_matrix

## Examples
1. 
```scilab
t = linspace(0,10,1000);

y = cos(t);

x = sin(t);

[pval,lm] = arch_test(y,x',1)

```
```output
pval = 0
lm = 229.01679
```

2.
```scilab
t = linspace(0,10,1000);
y = sin(t);
x = [ zeros(1,300) ones(1,400) zeros(1,300);zeros(1,200) ones(1,200) zeros(1,600);zeros(1,100) ones(1,400) zeros(1,500)];
[pval,lm] = arch_test(y,x',3)
```
```output
pval  = 

   0.
 lm  = 

   447.99516

```
3.
```scilab
t = linspace(-10,10,2000);
y = exp(t);
x = [sin(t);cos(t);tan(t)];
[pval,lm] = arch_test(y,x',5)
```
```output
Warning :
matrix is close to singular or badly scaled. rcond = 6.6096E-17
 pval  = 

   0.
 lm  = 

   16935.914

```
4.
```scilab
t= linspace(0,100,100);

y = t .* t + 2*t + 3;

 x = 3;

[pval,lm] = arch_test(y,x,1)

```
```output
 pval  = 

   0.
 lm  = 

   208.60268

```
5.
```scilab
t= linspace(0,10,1000);
x=[sin(t);cos(t);tan(t)];
[pval,lm] = arch_test(t,x',1)
```
```output
pval  = 

   0.
 lm  = 

   345.23194

```
