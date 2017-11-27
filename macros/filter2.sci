function Y = filter2 (B, X, SHAPE)

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 2 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 2 then
        Y=callOctave("filter2",B,X)
	case 3 then
		Y = callOctave("filter2",B,X,SHAPE)
    end

endfunction
