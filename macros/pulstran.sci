function y = pulstran(t, d, p, varargin)
//This function generates the signal y = sum(func(t+d,...)) for each d.
//Calling Sequence
//y = pulstran (t, d, func, ...)
//y = pulstran (t, d, p)
//y = pulstran (t, d, p, fs)
//y = pulstran (t, d, p, Ffs, meth)
//Parameters 
//t:
//d: vector or matrix 
//p:
//fs: default value 1Hz
//func: function which accepts vector (of times)
//Description
//This is an Octave function.
//This function generates the signal y = sum(func(t+d,...)) for each d. If d is a matrix of two columns, the first column is the delay d and the second column is the amplitude a, and y = sum(a*func(t+d)) for each d, a. Here, func is a function which accepts a vector of times. 
//If a pulse shape sampled at frequency Fs (default 1 Hz) is supplied instead of a function name, an interpolated version of the pulse is added at each delay d.
//Examples
//pulstran([0.5,9,8,7],[4,6],[-7,0.5])
//ans  =
//    0.    0.    0.    0.5  
funcprot(0);

rhs=argn(2)

if (rhs<3 |  rhs>5)
	error("Wrong input arguments.")
end
	select(rhs)
	case 1 then
	y = callOctave("pulstran",t)
	case 2 then
	y = callOctave("pulstran",t,d)
	case 3 then
	y = callOctave("pulstran",t, d, p)
	case 4 then
	y = callOctave("pulstran",t, d, p, varargin(1))
	case 5 then
	y = callOctave("pulstran",t, d, p, varargin(1),varargin(2))
	end
endfunction
