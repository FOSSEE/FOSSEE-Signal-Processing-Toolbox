function [PXX, FREQ] = cpsd(X, Y, varargin) 
//This function estimates cross power spectrum of data x and y by the Welch (1967) periodogram/FFT method.
//Calling Sequence
//[PXX, FREQ] = cpsd(X, Y)
//[...] = cpsd(X, Y, WINDOW)
//[...] = cpsd(X, Y, WINDOW, OVERLAP)
//[...] = cpsd(X, Y, WINDOW, OVERLAP, NFFT)
//[...] = cpsd(X, Y, WINDOW, OVERLAP, NFFT, FS)
//[...] = cpsd(X, Y, WINDOW, OVERLAP, NFFT, FS, RANGE)
//cpsd(...)
//Parameters
//X, Y: Matrix or integer
//Description
//Estimate cross power spectrum of data X and Y by the Welch (1967) periodogram/FFT method.
//Examples
// [a, b] = cpsd([1,2,3],[4,5,6])
//ans = 
//     b  = 
//          0.    
//          0.25  
//          0.5   
//     a  = 
//          2.7804939               
//          4.4785583 + 1.0743784i  
//          0.7729851               
funcprot(0);
rhs=argn(2);
lhs=argn(1);
if(rhs<2 | rhs>7) then
    error("Wrong number of input arguments.");
end
if (lhs<2 | lhs>2)
    error("Wrong number of output arguments.");
end
select(rhs)
case 2 then
    [PXX, FREQ] = callOctave("cpsd",X, Y);
case 3 then
    [PXX, FREQ] = callOctave("cpsd",X, Y, varargin(1));
case 4 then 
    [PXX, FREQ] = callOctave("cpsd",X, Y, varargin(1), varargin(2));
case 5 then
    [PXX, FREQ] = callOctave("cpsd",X, Y, varargin(1), varargin(2), varargin(3));
case 6 then
    [PXX, FREQ] = callOctave("cpsd",X, Y, varargin(1), varargin(2), varargin(3), varargin(4));
case 7 then 
    [PXX, FREQ] = callOctave("cpsd",X, Y, varargin(1), varargin(2), varargin(3), varargin(4), varargin(5)); 
end

endfunction
