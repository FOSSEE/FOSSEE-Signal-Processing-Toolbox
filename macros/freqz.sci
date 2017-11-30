function [H, W] = freqz(B, varargin) 
//This function returns the complex frequency response H of the rational IIR filter whose numerator and denominator coefficients are B and A, respectively.
//Calling Sequence
//[H, W] = freqz(B, A, N, "whole")
//[H, W] = freqz(B)
//[H, W] = freqz(B, A)
//[H, W] = freqz(B, A, N)
//H = freqz(B, A, W)
//[H, W] = freqz(..., FS)
//freqz(...)
//Parameters
//B, A, N: Integer or Vector
//Description
// Return the complex frequency response H of the rational IIR filter whose numerator and denominator coefficients are B and A, respectively.
//
//The response is evaluated at N angular frequencies between 0 and 2*pi.
//
//The output value W is a vector of the frequencies.
// 
//If A is omitted, the denominator is assumed to be 1 (this corresponds to a simple FIR filter).
//
//If N is omitted, a value of 512 is assumed. For fastest computation, N should factor into a small number of small primes.
//
//If the fourth argument, "whole", is omitted the response is evaluated at frequencies between 0 and pi.
//
//     'freqz (B, A, W)'
//
//Evaluate the response at the specific frequencies in the vector W. The values for W are measured in radians.
//
//     '[...] = freqz (..., FS)'
//
//Return frequencies in Hz instead of radians assuming a sampling rate FS. If you are evaluating the response at specific frequencies W, those frequencies should be requested in Hz rather than radians.
//
//     'freqz (...)'
//
//Plot the magnitude and phase response of H rather than returning them.
//Examples
//H = freqz([1,2,3], [4,3], [1,2,5])
//ans = 
//       0.4164716 - 0.5976772i  - 0.4107690 - 0.2430335i    0.1761948 + 0.6273032i  
funcprot(0);
rhs=argn(2);
lhs=argn(1);
if(rhs<2 | rhs>4) then
    error("Wrong number of input arguments.");
end
if (lhs<1 | lhs>2)
    error("Wrong number of output arguments.");
end
if (lhs==1) then
select(rhs)
case 1 then
    H = callOctave("freqz",B);
case 2 then
    H = callOctave("freqz",B, varargin(1));
case 3 then 
    H = callOctave("freqz",B, varargin(1), varargin(2));
end
elseif (lhs==2) then 
    select(rhs)
case 1 then
    [H, W] = callOctave("freqz",B);
case 2 then
    [H, W] = callOctave("freqz",B, varargin(1));
case 3 then 
    [H, W] = callOctave("freqz",B, varargin(1), varargin(2));
case 4 then 
    [H, W] = callOctave("freqz", B, varargin(1), varargin(2), varargin(3));
end    
end
endfunction
