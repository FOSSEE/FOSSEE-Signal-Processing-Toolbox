# xcorr2
## Description
Compute the 2D cross-correlation of matrices a and b.
If b is not specified, a's autocorrelation is computed, i.e., the same as xcorr2 (a, a).

The optional argument scale defines the type of scaling applied to the cross-correlation matrix.
## Calling Sequence

- `y = xcorr2( a )`
- ` y = xcorr2( a , b) `
-  ` y = xcorr2( a , b , scale) `
## Parameters

- `a, b`
  Matrices

- `scale :` A string from following options {"none" ( default)  , "biased" , " unbiased" ,"coeff" }
  
<h3> none (default)  </h3>
<div>  No scaling. </div>

<h3> biased </h3>
<div>
  Scales the raw cross-correlation by the maximum number of elements of a and b involved in the generation of any element of c.
</div>


<h3>unbiased </h3>
<div>
  Scales the raw correlation by dividing each element in the cross-correlation matrix by the number of products a and b used to generate that element.
</div>


<h3>coeff</h3>
<div>
  Scales the normalized cross-correlation on the range of [0 1] so that a value of 1 corresponds to a correlation coefficient of 1
</div>

## Examples
1. 
```scilab
a =[17   24    1    8   15;23    5    7   14   16;4    6   13   20   22;10   12   19   21    3;11   18   25    2    9 ];
 b = [6 13 22; 10 18 23; 8 15 23];
 xcorr2 (a, b,"unbiased")
 ```
```output

 ans  =

   43.444444   89.666667   57.666667   43.444444   52.555556   32.111111   13.333333
   102.22222   146.44444   116.11111   101.        125.88889   78.         30.888889
   110.55556   164.        148.66667   170.44444   226.66667   129.        47.333333
   92.         116.11111   166.77778   227.44444   234.22222   122.33333   37.777778
   63.444444   135.44444   230.44444   239.44444   210.66667   91.222222   26.      
   52.555556   111.77778   182.55556   161.88889   105.11111   38.555556   12.      
   26.888889   59.888889   94.444444   53.         41.555556   14.333333   6.  
```


2. 
```scilab
M1 = [17 24  1  8 15;
      23  5  7 14 16;
       4  6 13 20 22;
      10 12 19 21  3;
      11 18 25  2  9];

M2 = [8 1 6;
      3 5 7;
      4 9 2];
[r2,c2] = size(M2);
D = xcorr2(M1,M2);
DD = D(0+r2,2+c2)
```
```output
ans = 585 ```



3.
```scilab
xcorr2(M2)

```
```output
 ans = [5x5 double]

   16.   74.    53.    58.    24.
   62.   84.    142.   116.   46.
   77.   118.   285.   118.   77.
   46.   116.   142.   84.    62.
   24.   58.    53.    74.    16.

```

4.
```scilab
xcorr2(M1)
```
```output

 ans = [9x9 double]

   153.   250.    482.    980.    795.    512.    530.    358.    165.
   258.   520.    1478.   1384.   1380.   1282.   1120.   702.    326.
   479.   1428.   1515.   1598.   2195.   2086.   1842.   1070.   462.
   880.   1422.   1710.   2248.   3430.   3450.   1938.   1160.   662.
   840.   1540.   2060.   3360.   5525.   3360.   2060.   1540.   840.
   662.   1160.   1938.   3450.   3430.   2248.   1710.   1422.   880.
   462.   1070.   1842.   2086.   2195.   1598.   1515.   1428.   479.
   326.   702.    1120.   1282.   1380.   1384.   1478.   520.    258.
   165.   358.    530.    512.    795.    980.    482.    250.    153.
```

5.
```scilab
X = ones(2,3);
H = [1 2; 3 4; 5 6];  // H is 3 by 2
C = xcorr2(X,H,"coeff")

```
```output
 C = [4x4 double]

   0.6289709   0.8153742   0.8153742   0.5241424
   0.7412493   0.9434564   0.9434564   0.5929995
   0.4447496   0.5241424   0.5241424   0.2964997
   0.209657    0.2223748   0.2223748   0.1048285
```
