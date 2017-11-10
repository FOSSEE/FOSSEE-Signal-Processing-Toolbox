function y = idst1(x,varargin)
funcprot(0);
rhs=argn(2);
if(rhs<1 | rhs>2) then
    error("Wrong number of input arguments.");
end
select(rhs)
case 1 then
    y=callOctave("idst",x);
case 2 then
    y=callOctave("idst",x,varargin(1));
end

endfunction
