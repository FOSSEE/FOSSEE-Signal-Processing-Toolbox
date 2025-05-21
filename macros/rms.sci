
function y = rms(x, dim)
// Root mean squared value 
//
// Syntax
// Y=rms(X);
// Y=rms(X,dim);
//
// Description 
// For vectors, RMS(X) is the root mean squared value in X. For matrices,
//   RMS(X) is a row vector containing the RMS value from each column. For
//   N-D arrays, RMS(X) operates along the first non-singleton dimension.
//
//   Y = RMS(X,DIM) operates along the dimension DIM.
//
//   When X is complex, the RMS is computed using the magnitude
//   RMS(ABS(X)). 
//
// Examples
// // Compute the root mean squared (RMS) value of a vector and a matrix
// x = [1, 2, 3, 4]; 
// y1 = rms(x); 
// disp("RMS of vector:"); 
// disp(y1); 
// x_matrix = [1, 2; 3, 4; 5, 6]; 
// y2 = rms(x_matrix); 
// disp("RMS of matrix columns:"); 
// disp(y2); 
// y3 = rms(x_matrix, 2); 
// disp("RMS of matrix rows:"); 
// disp(y3);
// 
// Authors
// Debdeep Dey

//convert i/p values to their ascii values if they are of type char
if(type(x)==10) then
    xa=x;
    x=ascii(x);
    x=matrix(x,size(xa));
end

if argn(2)==1
    [rm,cm]=size(x);
    if(rm>1) then
        y = sqrt(mean((x .* conj(x)),'r'));
    else
        y=sqrt(mean((x.*conj(x))));     
    end
else
    if(dim==1)
        y = sqrt(mean((x .* conj(x)),'r'));
    else
        y = sqrt(mean((x .* conj(x)),'c'));
    end
end
endfunction
