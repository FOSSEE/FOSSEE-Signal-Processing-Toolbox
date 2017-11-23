function [y, xm]= rceps(x)

funcprot(0)
lhs= argn(1)
rhs= argn(2)

if(rhs <1 | rhs> 1 )
error("Wrong number of Input Arguments");
end

if(lhs<2 | lhs>2)
error("Wrong number of Output Arguments")
end

	[y,xm]= callOctave("rceps",x);

endfunction
