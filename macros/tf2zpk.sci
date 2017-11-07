//tf2zpk Convert transfer function filter parameters to zero-pole-gain
//form
//Calling Syntax :
// [z,p,k] = tf2zpk(b,a)
//where
//z=zeros of the corrsponding tf
//p=poles of the corresponding tf
//k=gain of the tf
//b=vector containing the numerator coefficients of the transfer function in descending powers of s
//a=vector containing the denominator coefficients of the transfer function in descending powers of s

function [zero, pole, gain] = tf2zpk(num, den)
    
    if argn(2)< 2 | isempty(den) then
        den = 1;
    end
    [num, den] = eqtflength(num, den);
    [zero, pole, gain] = tf2zp(num, den); 
    
endfunction
