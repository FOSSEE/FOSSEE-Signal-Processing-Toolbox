function y = idct2(x,varargin)
//This function computes the inverse 2-D discrete cosine transform of input matrix.
//Calling Sequence
//Y = idct2(X)
//Y = idct2(X, M, N)
//Y = idct2(X, [M, N])
//Parameters
//X: Matrix or integer
//M, N: If specified Matrix X is padded with M rows and N columns.
//Description
// This function computes the inverse 2-D discrete cosine transform of matrix X. If M and N are specified, the input is either padded or truncated to have M rows and N columns.
//Examples
//idct2(3, 4, 6)
//ans = 
//     2.811261   0.612372  -0.525856   0.250601   0.612372  -0.086516
funcprot(0);
rhs=argn(2);
if (rhs<1 | rhs>3) then
    error("Wrong number of input arguments.");
end
select(rhs)
case 1 then
    y=callOctave("idct2",x)
case 2 then 
    y=callOctave("idct2",x,varargin(1))
case 3 then
    y=callOctave("idct2",x,varargin(1),varargin(2))
end
endfunction
