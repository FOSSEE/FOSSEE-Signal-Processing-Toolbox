function y=fht(d,n,dim)
funcprot(0);
rhs=argn(2);
if(rhs<1 | rhs>3)
    error("Wrong number of input arguments.")
end
select(rhs)
case 1 then
    y=callOctave("fht",d)
case 2 then
    y=callOctave("fht",d,n)
case 3 then
    y=callOctave("fht",d,n,dim)
end

endfunction
