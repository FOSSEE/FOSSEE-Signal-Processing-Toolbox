function [x_r, t_r] = impz(b, a, n, fs)
// It gives Impulse response of digital filter

//Calling Sequence
//x_r = impz(b)
//x_r = impz(b, a)
//x_r = impz(b, a, n)
//x_r = impz(b, a, n, fs)
//[x_r, t_r] = impz(b, a, n, fs)

//Parameters
//x_r: impz chooses the number of samples and returns the response in the column vector, x_r.
//t_r : impz returns the sample times in the column vector, t_r
// b : numerator coefficients of the filter
// a : denominator coefficients of the filter
// n : samples of the impulse response   t(by default ,n = length(t) and  is computed automatically.
// fs : sampling frequency

//Description
//[x_r,t_r] = impz(b,a) returns the impulse response of the filter with numerator coefficients, b, and denominator coefficients, a. impz chooses the number of samples and returns the response in the column vector, x_r, and the sample times in the column vector, t_r. t_r = [0:n-1]' and n = length(t) is computed automatically.

//Examples
//[x_r,t_r]=impz([0 1 1],[1 -3 3 -1],10)
//OUTPUT :
// t_r = 0.    1.     2.    3.    4.       5.      6.      7.      8.       9
// x_r=  0.    1.    4.    9.    16.    25.    36.    49.....64......81

//[x_r,t_r]=impz(1,[1 1],5)
//OUTPUT
// t_r =   0.    1.    2.    3.    4
//x_r =   1.  - 1.    1.  - 1.    1.

//This function is being called from Octave


funcprot(0);
rhs = argn(2)
lhs = argn(1)
if(rhs<1 | rhs>4)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 1 then
	if(lhs==1)
	[x_r] = callOctave("impz",b)
	elseif(lhs==2)
	[x_r,t_r] = callOctave("impz",b)
	end
	case 2 then
	if(lhs==1)
	[x_r] = callOctave("impz",b,a)
	elseif(lhs==2)
	[x_r,t_r] = callOctave("impz",b,a)
	end
	case 3 then
	if(lhs==1)
	[x_r] = callOctave("impz",b,a,n)
	elseif(lhs==2)
	[x_r,t_r] = callOctave("impz",b,a,n)
	end
	case 4 then
	if(lhs==1)
	[x_r] = callOctave("impz",b,a,n,fs)
	elseif(lhs==2)
	[x_r,t_r] = callOctave("impz",b,a,n,fs)
	end
	end
endfunction
