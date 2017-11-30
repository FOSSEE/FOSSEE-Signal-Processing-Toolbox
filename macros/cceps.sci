function y = cceps (x,correct)
//Return the complex cepstrum of the vector x
//Calling Sequence
//cceps (x)
//cceps(x, correct)
//Parameters
//x: vector.
//correct: if 1, a correction method  is applied.
//Description
//This function return the complex cepstrum of the vector x. If the optional argument correct has the value 1, a correction method is applied. The default is not to do this.
//Examples
//cceps([1,2,3],1)
//ans = 
//     1.92565
//     0.96346
//    -1.09735

funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 1 then
	y = callOctave("cceps",x)
	case 2 then
	y = callOctave("cceps",x,correct)
	end
endfunction
