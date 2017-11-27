function Y = unwrap2 (X, TOL, DIM)

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 1 then
        Y = callOctave("unwrap",X)
	case 2 then
		Y = callOctave("unwrap",X,TOL)
    case 3 then
        Y = callOctave("unwrap",X,TOL,DIM)  
    end

endfunction
