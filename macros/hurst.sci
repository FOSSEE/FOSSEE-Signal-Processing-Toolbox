function y = hurst(x)
//  Estimate the Hurst parameter of sample X via the rescaled r statistic.
//Calling Sequence
//hurst(X)
//variable=hurst(X)
//Parameters 
//X: X is a matrix, the parameter of sample X via the rescaled r statistic
//Description
//This is an Octave function.
//This function estimates the Hurst parameter of sample X via the rescaled rstatistic.
funcprot(0);
rhs= argn(2);
if(rhs<1 | rhs>1)
	error("Wrong number of input arguments");
end

select(rhs)
	case 1 then
		y= callOctave("hurst", x);
end
endfunction
