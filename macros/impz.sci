function [x_r, t_r] = impz(b, a, n, fs)

//
//Calling Sequence
//x_r = impz(b)
//x_r = impz(b, a)
//x_r = impz(b, a, n)
//x_r = impz(b, a, n, fs)
//[x_r, t_r] = impz(b, a, n, fs)

//Parameters 
//

//Description

//Examples


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
