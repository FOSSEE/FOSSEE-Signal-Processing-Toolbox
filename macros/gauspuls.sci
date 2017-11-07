function [y]=gauspuls(t,fc,bw)

// Generates Gaussian-modulated sinusoidal pulses
// Calling Sequence
//	[y]=gauspuls(t,fc,bw)
//	[y]=gauspuls(t,fc)
//	[y]=gauspuls(t)
// Parameters
//	t: Real or complex valued vector or matrix
//	fc: Real non negative number or complex number
//	bw: Real positive number or complex number
// Description
//	This is an Octave function
//	This function returns a Gaussian RF pulse of unity amplitude at the times indicated in array t.
// Examples
// 1.	gauspuls(1,2,3)
//	ans= 1.427D-56
// 2.	gauspuls([1 2 3],1,1)
//	ans= 0.0281016    0.0000006    1.093D-14

funcprot(0);
rhs=argn(2);
if ( rhs<1 ) then
 	error ("Wrong number of input arguments.")
elseif (rhs==1)
	y= callOctave("gauspuls",t)
elseif (rhs==2)
	y= callOctave("gauspuls",t,fc)
else y= callOctave("gauspuls",t,fc,bw)
end
endfunction
