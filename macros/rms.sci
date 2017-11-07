//Root mean squared value \
//Y=rms(X);
//Y=rms(X,dim);
//For vectors, RMS(X) is the root mean squared value in X. For matrices,
//   RMS(X) is a row vector containing the RMS value from each column. For
//   N-D arrays, RMS(X) operates along the first non-singleton dimension.
//
//   Y = RMS(X,DIM) operates along the dimension DIM.
//
//   When X is complex, the RMS is computed using the magnitude
//   RMS(ABS(X)). 
//Author Debdeep Dey

function y = rms(x, dim)
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
