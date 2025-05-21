function k=lar2rc(g)
// lar2rc convert log area ratios to reflection coefficients.
// 
// Syntax
// k = lar2rc(g)
//
// Parameters
// g: define log area ratios.
// k: returns the reflection coefficients.
//
// Examples
// g = [0.6389 4.5989 0.0063 0.0163 -0.0163];
// k = lar2rc(g)
// 
// Author
// Jitendra Singh
//

//Modified to match MATLAB o/p when i/p is of type char and is a string by Debdeep Dey

  if or(type(g)==10) then
    [r,c]=size(g);
    if r==1 & c==1 then
        k=ones(1,length(g));
    else
        k=ones(size(g,1), size(g,2))
    end

else
    if ~isreal(g) then
        error('Log area ratios must be real.')
    end
    k=-(tanh(-g/2));
    end
endfunction
