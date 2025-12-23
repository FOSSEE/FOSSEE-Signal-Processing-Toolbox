function w = kaiser (m, varargin)
// Compute the filter coefficients of a Kaiser window.
//
// Syntax
//   w = kaiser(m)
//   w = kaiser(m, beta)
//
// Parameters
// m: Positive integer value representing the length of the Kaiser window.
// beta: (optional) Real scalar value representing the shape parameter of the Kaiser window. Default is 0.5.
// w: Output variable, a vector of real numbers representing the filter coefficients.
//
// Description
// The `kaiser` function computes the filter coefficients of a Kaiser window of length `m`.
// The second parameter `beta` determines the stopband attenuation of the Fourier transform of the window.
//
// Examples
// kaiser(6, 0.2)
// 

funcprot(0);
    rhs = argn(2)
    if(rhs<1 | rhs>2)
    error("Wrong number of input arguments.")
    end

    if length(varargin)==0 then
        bet = 0.5; //default value of beta is 0.5
    else
        bet = varargin(1);
    end

w = window('kr', m, bet) //default value of beta is 0.5
w = w' ;

endfunction
