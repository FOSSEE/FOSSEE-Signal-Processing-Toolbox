
function [ydb]=pow2db(y)
// Convert power values to decibels (dB).
//
// Syntax
//   ydb = pow2db(y)
//
// Parameters
// y: Input power values (scalar, vector, or matrix). Must be non-negative.
//
// Description
// The `pow2db` function converts power values specified in `y` to decibels (dB) using the formula:  
// ydb = 10 * log10(y).  
// If `y` contains zeros, the corresponding `ydb` values are set to -Inf.  
// If `y` contains negative values, an error is raised.
//
// Examples
// // Convert a single power value to dB:
//    y = 2000;
//    ydb = pow2db(y)
// 
// Authors
// Debdeep Dey
// 

rhs = argn(2)
if(rhs~=1)
error("Wrong number of input arguments.")
end
[r,c]=size(y);
if (find(real(y(:))<0))==[] then
    if abs(y(:))>=0 then
     for i=1:r
            for j=1:c
                if abs(y(i,j))>0 then
                    ydb(i,j)=10*log10(y(i,j));
                else 
                    ydb(i,j)=-%inf;
                end
            end 
        end

    
    end
else
        error("The power value must be non-negative")
end

endfunction

