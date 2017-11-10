function [b, a] = pei_tseng_notch (frequencies, bandwidths)

//Return coefficients for an IIR notch-filter.
//Calling Sequence
//[b, a] = pei_tseng_notch (frequencies, bandwidths)
//b = pei_tseng_notch (frequencies, bandwidths)
//Parameters 
//frequencies: filter frequencies
//bandwidths: bandwidths to be used with filter
//Description
//This is an Octave function.
//It return coefficients for an IIR notch-filter with one or more filter frequencies and according bandwidths. The filter is based on a all pass filter that performs phasereversal at filter frequencies.
//This leads to removal of those frequencies of the original and phase-distorted signal.
//Examples
//sf = 800; sf2 = sf/2;
//data=[[1;zeros(sf-1,1)],sinetone(49,sf,1,1),sinetone(50,sf,1,1),sinetone(51,sf,1,1)];
//[b,a]=pei_tseng_notch ( 50 / sf2, 2/sf2 )
//b =
//
//   0.99213  -1.83322   0.99213
//
//a =
//
//   1.00000  -1.83322   0.98426

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 2 | rhs > 2)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 2 then
		if(lhs==1)
		b = callOctave("pei_tseng_notch", frequencies, bandwidths)
		elseif(lhs==2)
		[b, a] = callOctave("pei_tseng_notch", frequencies, bandwidths)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction
