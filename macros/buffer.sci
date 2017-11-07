function [y, z, opt] = buffer (x, n, p, opt)
//This function buffers the given data into a matrix of signal frames
//Calling Sequence
//[y] = buffer (x, n)
//[y] = buffer (x, n, p)
//[y] = buffer (x, n, p)
//[y, z, opt] = buffer (...)
//Parameters 
//x: Data to be buffered
//n: Positive integer equal to number of rows in the produced data buffer
//p: Integer less than n, default value 0
//opt: In case of overlap, it can be a vector of length p or the string "nodelay", In case of underlap, it is an integer between 0 and p
//Description
//This function buffers the given data into a matrix of signal frames
//Examples
//buffer(1,3,2)
//ans =
//   0   0
//   0   1
//   1   0
//This function is being called from Octave

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 2 | rhs > 4)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 2 then
		if(lhs==1)
		y = callOctave("buffer",x,n)
		elseif(lhs==3)
		[y,z,opt] = callOctave("buffer",x,n)
		else
		error("Wrong number of output argments.")
		end

	case 3 then
		if(lhs==1)
		y = callOctave("buffer",x,n,p)
		elseif(lhs==3)
		[y,z,op] = callOctave("buffer",x,n,p)
		else
		error("Wrong number of output argments.")
	       	end
	case 4 then
		if(lhs==1)
		y = callOctave("buffer",x,n,p,opt)
		elseif(lhs==3)
		[y,z,opt] = callOctave("buffer",x,n,p,opt)
		else
		error("Wrong number of output argments.")
	       	end
	end
endfunction

