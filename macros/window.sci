function [w] = window (f, m, varargin)
//This function creates an m-point window from the function f given as input.
//Calling Sequence
//w = window(f, m)
//w = window(f, m, opts)
//Parameters 
//f: string value
//m: positive integer value
//opts: string value, takes in "periodic" or "symmetric"
//w: output variable, vector of real numbers
//Description
//This is an Octave function.
//This function creates an m-point window from the function f given as input, in the output vector w.
//f can take any valid function as a string, for example "blackmanharris".
//Examples
//window("hanning",5)
//ans  = 
//    0.   
//    0.5  
//    1.   
//    0.5  
//    0.  
funcprot(0);
rhs = argn(2)
if(rhs<2)
error("Wrong number of input arguments.")
end
	select(rhs)
	case 2 then
	[w] = callOctave("window",f,m)
	case 3 then
	[w] = callOctave("window",f,m,varargin(1))
	end
endfunction

