function R=rc2ac(k, R0)

//rlevinson function convert reflection coefficients to autocorrelation sequence.
// Calling Sequence
// a = rc2ac(k, R0)

// Parameters
// k: input argument reflection coefficients.
// R0: input argument zero lag autocorrelation
// R: return  autocorrelation sequence.

// Test cases
//k = [0.3090 0.9800 0.0031 0.0082 -0.0082];
//r0 = 0.1;
//Output:
//R  =
//    0.1
//  - 0.0309
//  - 0.0790948
//    0.0786627
//    0.0293629
//  - 0.0950000

//
// See also
//
// Author
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
