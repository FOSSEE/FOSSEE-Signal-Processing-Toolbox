function g=rc2lar(k)
    
//rc2lar convert  reflection coefficient to log area ratios.

// Calling Sequence
// g = rc2lar(k)
// Parameters
// k: define the reflection coefficients.
// g: returns log area ratios.
// Examples
//X = [0.5 0.3 0.8 0.9 0.4 0.05];
// g = rc2lar(X)
// See also
//
// Author
// Jitendra Singh
//  

      if or(type(k)==10) then
    error ('All reflection coefficients should have magnitude less than unity.  ')
end 

    
    
  if ~isreal(k) then
        error('Log area ratios not defined for complex reflection coefficients.')
    end
    
    if max(abs(k)) >= 1 then
    error ('All reflection coefficients should have magnitude less than unity.')
end
g=-2*atanh(-k);
endfunction
