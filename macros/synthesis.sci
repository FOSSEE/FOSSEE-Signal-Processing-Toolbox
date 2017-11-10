function x= synthesis(Y,C)

funcprot(0);
lhs= argn(1);
rhs= argn(2);

if(rhs<2 | rhs >2)
	error("Wrong number of input arguments");
end

select(rhs)
	case 2 then
            x= callOctave("synthesis", Y,C);

end
endfunction
