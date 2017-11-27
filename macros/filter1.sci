function [Y, SF] = filter1 (B, A, X, SI, DIM)

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 3 | rhs > 5)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 3 then
		if(lhs==1)
		Y=callOctave("filter",B,A,X)
		elseif(lhs==2)
		[Y, SF] = callOctave("filter",B,A,X)
		else
		error("Wrong number of output arguments.")
		end
	case 4 then
		if(lhs==2)
		[Y, SF] = callOctave("filter",B,A,X,SI)
		else
		error("Wrong number of output arguments.")
	    end
	case 5 then
		if(lhs==2)
		[Y, SF] = callOctave("filter",B,A,X,SI,DIM)
		else
		error("Wrong number of output arguments.")
	    end
	
	end
endfunction
