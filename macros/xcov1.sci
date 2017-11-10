function [R,lag] = xcov1(X, Y, biasflag)

funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>3)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 1 then
	[R,lag] = callOctave("xcov",X);
	case 2 then
	[R,lag] = callOctave("xcov",X,Y);
	case 3 then
	[R,lag] = callOctave("xcov",X,Y,biasflag);
	end
endfunction
