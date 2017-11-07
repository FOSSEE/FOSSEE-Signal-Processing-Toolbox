// polyscale Scaling roots of a polynomial
// scales the roots of a polynomial in the z plane
//Syntax:
//b = polyscale(a,alpha)
// where
//a is the vector containing the polynomial coefficients
// alpha is the scaling vector

// Author
//Debdeep Dey
function  b = polyscale(a,alpha)
//errcheck1
if(min(size(a))>1) then
	error('Input polynomial must be an array')    
end
if type(a)==10 then
    error("Input cannot be of type char");
end
   b = a .* (alpha .^ (0:length(a)-1));

endfunction
