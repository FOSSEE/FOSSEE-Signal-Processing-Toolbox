function [y] = tripuls(t,w,skew)

//This function generates a triangular pulse over the interval [-w/2,w/2] sampled at times t 
//Calling Sequence
//[y] = tripuls(t)
//[y] = tripuls(t,w)
//[y] = tripuls(t,w,skew)
//Parameters 
//t: vector of real or complex numbers 
//w: real or complex number 
//skew: real number, -1 <= s <= 1
//Description
//This function generates a triangular pulse which is sampled at times t over the interval [-w/2,w/2]. The value of skew lies between -1
//and 1.
//The value of skew represents the relative placement of the peak in the given width.
//Examples
//tripuls([0, .5, .6, 1], 0.9)
//ans =
//   1   0   0   0
//This function is being called from Octave

funcprot(0);

rhs = argn(2)

if(rhs<1 | rhs>3)
error("Wrong number of input arguments.")
end
	select(rhs)
	case 1 then
		y = callOctave("tripuls",t)
	case 2 then
		y = callOctave("tripuls",t,w)
	case 3 then
		//tip = type(skew)
		//if(tip==1)
		y = callOctave("tripuls",t,w,skew)
		//else
		//error("Wrong arguments.")
		//end
	end
endfunction


