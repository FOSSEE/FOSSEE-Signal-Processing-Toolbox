function [Num,Den,AllpassNum,AllpassDen] = iirlp2mb(varargin)
//This function does IIR Low Pass Filter to Multiband Filter Transformation.
//Calling Sequence
//[Num, Den, AllpassNum, AllpassDen] = iirlp2mb(B, A, Wo, Wt)
//[Num, Den, AllpassNum, AllpassDen] = iirlp2mb(B, A, Wo, Wt, Pass)
//Parameters 
//B: real or complex value
//A: real or complex value
//Wo: scalar or vector
//Wt: scalar or vector, elements must be monotonically increasing and >= 0 and <= 1.
//Description
//This is an Octave function.
//This function does IIR Low Pass Filter to Multiband Filter Transformation.
//The first two parameters give the numerator and denominator of the prototype low pass filter.
//The third parameter is the normalized angular frequency/pi to be transformed.
//The fourth parameter is the normalized angular frequency/pi target vector.
//The first two output variables are the numerator and denominator of the transformed filter.
//The third and fourth output variables are the numerator and denominator of the allpass transform.
//The fifth parameter can have values pass or stop, default value is pass.
//Examples
//iirlp2mb(5,9,0.3,0.4)
//ans =  0.55556

B = varargin(1)
A = varargin(2)
Wo = varargin(3)
Wt = varargin(4)
rhs = argn(2)
lhs = argn(1)
if(rhs < 4 | rhs > 5)
error("Wrong number of input arguments.")
end
select(rhs)
case 4 then
[Num,Den,AllpassNum,AllpassDen] = callOctave("iirlp2mb",varargin(1),varargin(2),varargin(3),varargin(4))
case 5 then
[Num,Den,AllpassNum,AllpassDen] = callOctave("iirlp2mb",varargin(1),varargin(2),varargin(3),varargin(4),varargin(5))
end
endfunction


