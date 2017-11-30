function res = qp_kaiser (nb, at, linear)
//Computes a finite impulse response (FIR) filter for use with a quasi-perfect reconstruction polyphase-network filter bank.
//Calling Sequence
//qp_kaiser (nb, at, linear)
//qp_kaiser (nb, at)
//Parameters 
//nb: Number of bands
//at: Attenuation
//linear: When not zero, minimum-phase calculation is omitted.
//Description
//This is an Octave function.
//This version utilizes a Kaiser window to shape the frequency response of the designed filter. Tha number nb of bands and the desired attenuation at in the stop-band are given as parameters.
//
//The Kaiser window is multiplied by the ideal impulse response h(n)=a.sinc(a.n) and converted to its minimum-phase version by means of a Hilbert transform.
//Examples
// qp_kaiser (5, 5, 1)
//ans =
//
//   0.11591   0.25606   0.25606   0.25606   0.11591

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 2 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 2 then
	res = callOctave("qp_kaiser", nb, at)

	case 3 then
	res = callOctave("qp_kaiser", nb, at, linear)

	end
endfunction
