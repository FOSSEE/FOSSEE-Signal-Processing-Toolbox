function [k,R0] = ac2rc(R)
// Convert autocorrelation sequence to reflection coefficients. 
//
// Calling Sequence
// k = ac2rc(R)
// [k,R0] = ac2rc(R)
//
// Parameters
// R: The input autocorrelation sequence. If r is a matrix, each column of r is treated as a separate signal.
// k: Returns the reflection coefficients
// R0: the zero lag autocorrelation, R0, based on the autocorrelation sequence, R.
//
// Examples
// X = [7 6 5 8 3 6 8 7 5 2 4 7 4 3 2 5 4 9 5 3 5 7 3 9 4 1 2 0 5 4 8 6 4 6 5 3];
// [k,R0] = ac2rc(X)
// or t=[2 5 6; 8 6 5; 8 9 4]
// [k,R0] = ac2rc(t)
//
// Author
// Jitendra Singh
// 

 // call function "levin" before running this function

if or(type(R)==10) then
    error ('Input arguments must be double.')
end
 
if isvector(R) then
    R=R(:);

    [x,y,z] = levin(R)
k=z;
R0=R;

else
    n=size(R);
    
    for i=1:n(2)
        r=R(:,i);
 
     [x,y, z] = levin(r) 
         
 kk(:,i)= z; 

k=kk;   
R0=R(1,:);
       end
    
    end
endfunction
