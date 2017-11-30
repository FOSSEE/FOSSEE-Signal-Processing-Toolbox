function y= durbinlevinson(C, varargin)
// Perform one step of the Durbin-Levinson algorithm..
//Calling Sequence
// durbinlevinson (C);
// durbinlevinson (C, OLDPHI);
// durbinlevinson (C, OLDPHI, OLDV);
//Parameters 
//C: The vector C specifies the autocovariances '[gamma_0, ..., gamma_t]' from lag 0 to T.
//OLDPHI: It specifies the coefficients based on C(T-1).
//OLDV: It specifies the corresponding error.
//Description
//This is an Octave function.
//Perform one step of the Durbin-Levinson.
//If OLDPHI and OLDV are omitted, all steps from 1 to T of the algorithm are performed.
	rhs=argn(2);
	if(rhs<1 | rhs>3)
		error("Wrong number of input arguments");
	end
	select(rhs)
	case 1 then
		y=callOctave("durbinlevinson",C);
	case 2 then
		y=callOctave("durbinlevinson",C, varargin(1));
	case 3 then
		y=callOctave("durbinlevinson",C, varargin(1), varargin(2));
	end
endfunction