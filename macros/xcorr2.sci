function c = xcorr2 (a, b, biasflag)
//
//Calling Sequence
//c = xcorr2 (a)
//c = xcorr2 (a, b)
//c = xcorr2 (a, b, biasflag)
//Parameters 
//a:
//b:
//biasflag:
//Description
//This is an Octave function.

//Examples
//xcorr2(5,0.8,'coeff')
//ans =  1

funcprot(0);

rhs = argn(2)
if(rhs<1 | rhs>3)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 1 then
	c = callOctave("xcorr2",a);
	case 2 then
	c = callOctave("xcorr2",a,b);
	case 3 then
	c = callOctave("xcorr2",a,b,biasflag);
	end;
endfunction

