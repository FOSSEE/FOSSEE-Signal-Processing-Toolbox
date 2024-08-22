# fht: Fast Hartley Transform Function 
## Description
 This function calculates the Fast Hartley transform of real input D.
        If D is a matrix, the Hartley transform is calculated along the columns by default.
        If N is specified, the first N elements along the specified dimension are used for the transform.
        If DIM is specified, the transform is calculated along the specified dimension.
## Calling sequences
- `fht(d)`

- `fht(d, n)`

- `fht(d, n, dim)`
# Parameters:

- `d` : The real input array or matrix for which the FHT is to be computed.

- `n` (optional): A positive integer specifying the desired output size along each dimension (similar to the fft function).

If not provided, the original size of d is used.

If n is larger than the dimension along which the FHT is calculated, d is resized and padded with zeros.

If n is smaller, d is truncated.

- `dim` (optional): An integer specifying the dimension along which to perform the FHT.

By default, the transform is computed along columns (dim=1) for matrices.


## Examples
1. 
```scilab

fht([2 3 4;9 1 0;11 33 26]);
```
```output
 ans  =

   22.         37.         30.     
  -9.7320508  -41.712813  -31.51666
  -6.2679492   13.712813   13.51666
```

2.

```scilab
fht([9 7;2 0],10,2);
```
```output
ans  =

         column 1 to 7

   16.   18.777616   17.820515   13.494277   7.4513778   2.  -0.7776157
   2.    2.          2.          2.          2.          2.   2.       

         column 8 to 10

   0.1794854   4.5057233   10.548622
   2.          2.          2.       
```


3. 
```scilab
fht([2 7 8;0 0 2;2 4 8;0 9 1],2)
```
```output
ans  =

   2.   7.   10.
   2.   7.   6. 
```
4. 
```scilab
d=[1 8 9;7 6 5;2 7 5];d(:,:,2)=[10 11 12;3 8 1;0 7 1]
fht(d,[],3);
```
```output
 ans  =

(:,:,1)

   11.   19.   21.
   10.   14.   6. 
   2.    14.   6. 
(:,:,2)

  -9.  -3.  -3.
   4.  -2.   4.
   2.   0.   4.
```
5.
```scilab
fht([8 19 7 3]);
```
```output
 ans  =

   37.   17.  -7.  -15.
```




