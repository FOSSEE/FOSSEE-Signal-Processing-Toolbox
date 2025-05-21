function [zero, pole, gain] = tf2zpk(num, den)
// Converts transfer function filter parameters to zero-pole-gain form
//
// Syntax
// [z,p,k] = tf2zpk(b,a)
//
// Parameters
// z : zeros of the corrsponding tf
// p : poles of the corresponding tf
// k : gain of the tf
// b : vector containing the numerator coefficients of the transfer function in descending powers of s
// a : vector containing the denominator coefficients of the transfer function in descending powers of s
// 
// Examples
// // Convert transfer function to zero-pole-gain form
// // Define the numerator and denominator coefficients of the transfer function
// num = [1, -3, 2]; // Coefficients of s^2 - 3s + 2
// den = [1, -2, 1]; // Coefficients of s^2 - 2s + 1
// // Convert to zero-pole-gain form
// [z, p, k] = tf2zpk(num, den);
// // Display the results
// disp("Zeros of the transfer function:");
// disp(z);
// disp("Poles of the transfer function:");
// disp(p);
// disp("Gain of the transfer function:");
// disp(k);
// 
// See also
// eqtflength
// tf2zp

    if argn(2)< 2 | isempty(den) then
        den = 1;
    end
    [num, den] = eqtflength(num, den);
    [zero, pole, gain] = tf2zp(num, den); 
    
endfunction
