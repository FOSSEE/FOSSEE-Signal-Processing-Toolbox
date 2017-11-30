function y= fractdiff(x,d)
//Compute the fractional differences (1-L)^d x where L denotes the lag-operator and d is greater than -1.
//Calling Sequence
// fractdiff (X, D)
//Description
//This is an Octave function.
//Compute the fractional differences (1-L)^d x where L denotes the lag-operator and d is greater than -1.
	funcprot(0);
	rhs= argn(2);
	if(rhs < 2 | rhs >2)
		error("Wrong number of input arguments");
	end
	select(rhs)
	case 2 then
		y= callOctave("fractdiff",x,d);
	end
endfunction