function [y] = chirp(t,f0,t1,f1,frm,phse)
//This function evaluates a chirp signal at time t.
//Calling Sequence
//y = chirp(t)
//y = chirp(t, f0)
//y = chirp(t, f0, t1)
//y = chirp(t, f0, t1, f1)
//y = chirp(t, f0, t1, f1, frm)
//y = chirp(t, f0, t1, f1, frm, phse)
//Parameters 
//t: vector
//f0:
//t1:
//f1:
//frm: string value, takes in "linear", "quadratic", "logarithmic"
//phse:
//Description
//This is an Octave function.
//This function evaluates a chirp signal at time t. A chirp signal is a frequency swept cosine wave.
//The first argument is a vector of times to evaluate the chirp signal, second argument is the frequency at t=0, third argument is time t1 and fourth argument is frequency at t1.
//The fifth argument is the form which takes in values "linear", "quadratic" and "logarithmic", the sixth argument gives the phase shift at t=0.
//Examples
//chirp([4,3,2,1],4,5,0.9)
//ans  =
//           column 1 to 3
//    0.9685832    0.2486899    0.0627905  
//         column 4
//  - 0.3681246  
 
funcprot(0);

rhs = argn(2)
if(rhs<1 | rhs>6)
error("Wrong number of input arguments.")
end
	select(rhs)
	case 1 then
		y = callOctave("chirp",t)
	case 2 then
		y = callOctave("chirp",t,f0)
	case 3 then
		y = callOctave("chirp",t,f0,t1)
	case 4 then
		y = callOctave("chirp",t,f0,t1,f1)
	case 5 then
		//if(~(form == "linear" | form == "quadratic" | form == "logarithmic"))
		//error("Chirp does not understand that form. Enter linear, quadratic or logarithmic.")
		//else
		y = callOctave("chirp",t,f0,t1,f1,frm)
		//end
	case 6 then
		y = callOctave("chirp",t,f0,t1,f1,frm,phse)
	end
endfunction
		
