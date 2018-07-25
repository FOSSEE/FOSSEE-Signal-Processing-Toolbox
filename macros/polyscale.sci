// polyscale Scaling roots of a polynomial
// scales the roots of a polynomial in the z plane
//Syntax:
//b = polyscale(a,alpha)
// where
//a is the vector containing the polynomial coefficients
// alpha is the scaling vector
//
//EXAMPLES:
//to scale the seventh roots of unity ,x^7=1,
////we represent
//p=[1 0 0 0 0 0 0 -1]   and changing the scaling factor,
//b=polyscale(p,0.85)
//EXPECTED OUTPUT:b=1.    0.    0.    0.    0.    0.    0.  - 0.3205771


//p=[1 0 0 0 0 0 0 -1]   and changing the scaling factor,
//b=polyscale(p,0.95)
//EXPECTED OUTPUT:b=1.    0.    0.    0.    0.    0.    0.  - 0.6983373
//

//p=[1 0 0 0 0 0 0 -1]   and changing the scaling factor,
//b=polyscale(p,1)
//EXPECTED OUTPUT:b=1.    0.    0.    0.    0.    0.  -1


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
