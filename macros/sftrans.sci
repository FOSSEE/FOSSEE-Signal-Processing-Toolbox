function [Sz, Sp, Sg] = sftrans (Sz, Sp, Sg, W, stop)
//Transform band edges of a generic lowpass filter (cutoff at W=1) represented in splane zero-pole-gain form.
//Calling Sequence
//[Sz, Sp, Sg] = sftrans (Sz, Sp, Sg, W, stop)
//[Sz, Sp] = sftrans (Sz, Sp, Sg, W, stop)
//[Sz] = sftrans (Sz, Sp, Sg, W, stop)
//Parameters
//Sz: Zeros.
//Sp: Poles.
//Sg: Gain.
//W: Edge of target filter.
//stop: True for high pass and band stop filters or false for low pass and band pass filters.
//Description
//This is an Octave function.
//Theory: Given a low pass filter represented by poles and zeros in the splane, you can convert it to a low pass, high pass, band pass or band stop by transforming each of the poles and zeros
//individually. The following table summarizes the transformation:
//
// Transform         Zero at x                  Pole at x
// ----------------  -------------------------  ------------------------
// Low Pass          zero: Fc x/C               pole: Fc x/C
// S -> C S/Fc       gain: C/Fc                 gain: Fc/C
// ----------------  -------------------------  ------------------------
// High Pass         zero: Fc C/x               pole: Fc C/x
// S -> C Fc/S       pole: 0                    zero: 0
//                   gain: -x                   gain: -1/x
// ----------------  -------------------------  ------------------------
// Band Pass         zero: b +- sqrt(b^2-FhFl)  pole: b +- sqrt(b^2-FhFl)
//        S^2+FhFl   pole: 0                    zero: 0
// S -> C --------   gain: C/(Fh-Fl)            gain: (Fh-Fl)/C
//        S(Fh-Fl)   b=x/C (Fh-Fl)/2            b=x/C (Fh-Fl)/2
// ----------------  -------------------------  ------------------------
// Band Stop         zero: b +- sqrt(b^2-FhFl)  pole: b +- sqrt(b^2-FhFl)
//        S(Fh-Fl)   pole: +-sqrt(-FhFl)        zero: +-sqrt(-FhFl)
// S -> C --------   gain: -x                   gain: -1/x
//        S^2+FhFl   b=C/x (Fh-Fl)/2            b=C/x (Fh-Fl)/2
// ----------------  -------------------------  ------------------------
// Bilinear          zero: (2+xT)/(2-xT)        pole: (2+xT)/(2-xT)
//      2 z-1        pole: -1                   zero: -1
// S -> - ---        gain: (2-xT)/T             gain: (2-xT)/T
//      T z+1
// ----------------  -------------------------  ------------------------
// 
//where C is the cutoff frequency of the initial lowpass filter, Fc is the edge of the target low/high pass filter and [Fl,Fh] are the edges of the target band pass/stop filter. With abundant tedious
//algebra, you can derive the above formulae yourself by substituting the transform for S into H(S)=S-x for a zero at x or H(S)=1/(S-x) for a pole at x, and converting the result into the form:
//
//    H(S)=g prod(S-Xi)/prod(S-Xj)
//Examples
//[Sz, Sp, Sg] = sftrans (5, 10, 15, 20, 30)
//Sz =  4
//Sp =  2
//Sg =  7.5000

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 5 | rhs > 5)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 5 then
		if(lhs==1)
		Sz = callOctave("sftrans",Sz, Sp, Sg, W, stop)
		elseif(lhs==2)
		[Sz, Sp] = callOctave("sftrans",Sz, Sp, Sg, W, stop)
		elseif(lhs==3)
		[Sz, Sp, Sg] = callOctave("sftrans",Sz, Sp, Sg, W, stop)
		else
		error("Wrong number of output argments.")
		end

	end
endfunction
