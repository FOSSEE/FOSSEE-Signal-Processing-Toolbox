function R=rc2ac(k, R0)
// Convert reflection coefficients to autocorrelation sequence.
//
// Syntax
// a = rc2ac(k, R0)
// 
// Parameters
// k: input argument reflection coefficients.
// R0: input argument zero lag autocorrelation
// R: return  autocorrelation sequence.
// 
// See also
//
// Authors
// Jitendra Singh
//

 // load rc2poly and rlevinson before running this function

       if or(type(k)==10) then
    error ('Input arguments must be double.')
end

 if (size(k,1) > 1) & (size(k,2) > 1)
    error ('The reflection coefficients must be stored in a vector.')
end


     if argn(2)<2 then // checking of number of input arguments, if argn(2)<2 execute error.
              error ('Not enough input argument, define zero lag autocorrelation, R0.')
    end
    if or(k(2:$)==1) then
        error('Algorithm failed for this case. At least one of the reflection coefficients is equal to one.')
    end

    [a, efinal]=rc2poly (k, R0);
    R=rlevinson(a, efinal)


endfunction
