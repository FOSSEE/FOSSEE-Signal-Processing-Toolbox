function [zc, zr] = cplxreal (z, thresh)
//Function to divide vector z into complex and real elements, removing the one of each complex conjugate pair.
//Calling Sequence
//[zc, zr] = cplxreal (z, thresh)
//[zc, zr] = cplxreal (z)
//zc = cplxreal (z, thresh)
//zc = cplxreal (z)
//Parameters 
//z: vector of complex numbers.
//thresh: tolerance for comparisons.
//zc: vector containing the elements of z that have positive imaginary parts.
//zr: vector containing the elements of z that are real.
//Description
//This is an Octave function.
//Every complex element of z is expected to have a complex-conjugate elsewhere in z. From the pair of complex-conjugates, the one with the negative imaginary part is removed.
//If the magnitude of the imaginary part of an element is less than the thresh, it is declared as real.  
//Examples
//[zc, zr] = cplxreal([1 2 3+i 4 3-i 5])
//zc =  3 + 1i
//zr =
//   1   2   4   5
funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 2)
error("Wrong number of input arguments.")
end

select(rhs)
	case 1 then
		if(lhs==1)
		zc = callOctave("cplxreal",z)
		elseif (lhs==2)
		[zc, zr] = callOctave("cplxreal",z)
		else
		error("Wrong number of output argments.")
		end

	case 2 then
		if(lhs==1)
		zc = callOctave("cplxreal",z, thresh)
		elseif (lhs==2)
		[zc, zr] = callOctave("cplxreal",z, thresh)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction
