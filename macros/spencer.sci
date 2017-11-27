function y= spencer(x)
//Return Spencer's 15 point moving average of each column of X.
//Calling Sequence
//spencer(X)
//Parameters 
//X: Real scalar or vector
//Description
//Return Spencer's 15 point moving average of each column of X.
funcprot(0);

rhs= argn(2);

if(rhs <1 | rhs >1)
error("Wrong number of input arguments");
end

select(rhs)
	case 1 then
		y = callOctave("spencer",x);
end
endfunction
