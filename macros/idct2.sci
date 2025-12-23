function y = idct2 (x, m, n)
// Compute the inverse 2-D discrete cosine transform.
//
// Syntax
//   Y = idct2(X)
//   Y = idct2(X, M, N)
//   Y = idct2(X, [M, N])
//
// Parameters
// X: Input matrix or integer.
// M, N: (optional) If specified, the input matrix X is padded or truncated to have M rows and N columns.
//
// Description
// Computes the inverse 2-D discrete cosine transform of the input matrix X. If M and N are specified, the input is either padded or truncated to match the specified dimensions.
//
// Examples
// idct2(3, 4, 6)
// 

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
