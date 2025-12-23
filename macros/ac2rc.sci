function [k,R0] = ac2rc(R)
// Convert autocorrelation sequence to reflection coefficients.
//
// Syntax
//   k = ac2rc(R)
//   [k,R0] = ac2rc(R)
//
// Parameters
// R: The input autocorrelation sequence. If R is a matrix, each column of R is treated as a separate signal.
// k: Reflection coefficients derived from the autocorrelation sequence.
// R0: The zero-lag autocorrelation, based on the autocorrelation sequence R.
//
// Description
// Function ac2rc() computes the reflection coefficients `k` and the zero-lag autocorrelation `R0` 
// from the given autocorrelation sequence `R`. If `R` is a matrix, the function processes each column 
// as a separate signal.
//
// Examples
// t = [2 5 6; 8 6 5; 8 9 4]
// [k,R0] = ac2rc(t)
//
// See also
//  levin
//
// Authors
//  Jitendra Singh
//

if or(type(R)==10) then
    error ('Input arguments must be double.')
end
 
if isvector(R) then
    R = R(:);

    [x, y, z] = _levin(R);
    k = z;
    R0 = R;

else
    n = size(R);
    
    for i = 1:n(2)
        r = R(:,i);
        [x, y, z] = _levin(r);
        kk(:,i) = z; 
    end

    k = kk;   
    R0 = R(1,:);
end

endfunction
