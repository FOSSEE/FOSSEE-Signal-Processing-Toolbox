function [A,V]= yulewalker(C)

funcprot(0);
lhs=argn(1);
rhs= argn(2);

if(rhs<1 | rhs>1)
	error("Wrong number of input arguments");
end

if(lhs<1 | lhs>2)
	error("Wrong number of output arguments");
end

select(lhs)

	case 1 then
		A= callOctave("yulewalker", C);
	case 2 then
		[A,V]= callOctave("yulewalker", C);
end
endfunction 


