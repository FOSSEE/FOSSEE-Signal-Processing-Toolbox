function [a, efinal] = rc2poly(kr, R0)

//rc2poly function  convert reflection coefficients to prediction polynomial.
// Calling Sequence
// a = rc2poly(kr)
// [a, efinal] = rc2poly(kr,R0)

// Parameters
// kr: Refelection coefficient.
// R0: the zero lag autocorrelation, R0.
// a: Return the prediction polynomial.
// efinal: Return the final prediction error.

// Examples
//X = [7 6 5 8 3 6]
// [a, efinal] = rc2poly(X)  //error as only one input parameter is specified.(R0 is not mentioned)
//
//k = [0.3090 0.9800 0.0031 0.0082 -0.0082];
//a = rc2poly(k)
//EXPECTED OUTPUT:a= 1.    0.6148162    0.9898814    0.0000243    0.0031580     - 0.0082
//
// See also
//
// Author
// Jitendra Singh
//
       if or(type(kr)==10) then
    error ('Input arguments must be double.')
end

if (size(kr,1) > 1) & (size(kr,2) > 1)
    error ('The reflection coefficients must be stored in a vector.')
end

kr=kr(:);

if argn(2)<2 & argn(1)==2 then
          error ('Zero lag autocorrelation, R0, not specified.')
end


if argn(2)<2 then
          e=0;
else
          e=R0;
end

ee(1) = e.*(1-kr(1)'.*kr(1));
a=kr(1);


for i=2:length(kr)
      a = [a + a(i-1:-1:1)*kr(i) kr(i)]
    ee=ee.*(1-kr(i)'.*kr(i));
end

a=[1 a];
efinal=ee;

endfunction
