function y = idct2(x,varargin)
funcprot(0);
rhs=argn(2)
if (rhs<1 | rhs>3) then
    error("Wrong number of input arguments.")
end
select(rhs)
case 1 then
    y=callOctave("idct2",x)
case 2 then 
    y=callOctave("idct2",x,varargin(1))
case 3 then
    y=callOctave("idct2",x,varargin(1),varargin(2))
end
endfunction
