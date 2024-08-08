/*Description
    This function computes the inverse 2-D discrete cosine transform of matrix X. If M and N are specified, the input is either padded or truncated to have M rows and N columns.
Calling Sequence
        Y = idct2(X)
        Y = idct2(X, M, N)
        Y = idct2(X, [M, N])
Parameters
        X: Matrix or integer
        M, N: If specified Matrix X is padded with M rows and N columns.
Examples
     idct2(3, 4, 6)
     ans =
         2.811261   0.612372  -0.525856   0.250601   0.612372  -0.086516 */
function y = idct2 (x, m, n)
   funcprot(0);
   rhs=argn(2);
   select (rhs)
   case 1 then
       [m,n]=size(x);
   case 2 then    
        n=m(2);
        m=m(1);
   end
   if m==1 then
       y=idct1(x.',n).';
   elseif n==1 then
       y=idct1(x,m);
   else
       y=idct1(idct1(x,m).',n).';        
   end
endfunction
