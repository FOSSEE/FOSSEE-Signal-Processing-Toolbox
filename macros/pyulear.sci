function [psd,f_out] = pyulear(x,poles,freq,Fs,range,method,plot_type)

//Calculates a Yule-Walker autoregressive (all-pole) model of the data "x" and computes the power spectrum of the model.
//Calling Sequence
//[psd,f_out] = pyulear(x,poles,freq,Fs,range,method,plot_type)
//All but the first two arguments are optional and may be empty.
//Parameters 
//   x:       [vector] sampled data
//   poles:    [integer scalar] required number of poles of the AR model
//   freq:     [real vector] frequencies at which power spectral density is calculated [integer scalar] number of uniformly distributed frequency values at which spectral density is calculated.    [default=256]
//   Fs:       [real scalar] sampling frequency (Hertz) [default=1]
//   range:    'half',  'onesided' : frequency range of the spectrum is from zero up to but not including sample_f/2.  Power from negative frequencies is added to the positive side of the spectrum.   'whole', 'twosided' : frequency range of the spectrum is -sample_f/2 to sample_f/2, with negative frequencies stored in "wrap around" order after the positive frequencies; e.g. frequencies for a 10-point 'twosided' spectrum are 0 0.1 0.2 0.3 0.4 0.5 -0.4 -0.3 -0.2 -0.1 'shift', 'centerdc' : same as 'whole' but with the first half of the spectrum swapped with second half to put the zero-frequency value in the middle. (See "help fftshift". If "freq" is vector, 'shift' is ignored. If model coefficients "ar_coeffs" are real, the default range is 'half', otherwise default range is 'whole'.
//   method:   'fft':  use FFT to calculate power spectral density. 'poly': calculate spectral density as a polynomial of 1/z N.B. this argument is ignored if the "freq" argument is a vector.  The default is 'poly' unless the "freq" argument is an integer power of 2.
// plot_type:  'plot', 'semilogx', 'semilogy', 'loglog', 'squared' or 'db' specifies the type of plot.  The default is 'plot', which means linear-linear axes. 'squared' is the same as 'plot'. 'dB' plots "10*log10(psd)".  This argument is ignored and a spectrum is not plotted if the caller requires a returned value.

//Description
//This function is being called from Octave.
//This function is a wrapper for aryule and ar_psd.
//See "help aryule" and "help ar_psd" for further details.
//Examples
//a = [1.0 -1.6216505 1.1102795 -0.4621741 0.2075552 -0.018756746];
//[psd,f_out] = pyulear(a,2);

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 2 | rhs > 7)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 2 then
		if(lhs==1)
		psd = callOctave("pyulear",x,poless)
		elseif(lhs==2)
		[psd,f_out] = callOctave("pyulear",x,poles)
		else
		error("Wrong number of output argments.")
		end

	case 3 then
		if(lhs==1)
		psd = callOctave("pyulear",x,poles,freq)
		elseif(lhs==2)
		[psd,f_out] = callOctave("pyulear",x,poles,freq)
		else
		error("Wrong number of output argments.")
	       	end
	case 4 then
		if(lhs==1)
		psd = callOctave("pyulear",x,poles,freq,Fs)
		elseif(lhs==2)
		[psd,f_out] = callOctave("pyulear",x,poles,freq,Fs)
		else
		error("Wrong number of output argments.")
	       	end
	case 5 then
		if(lhs==1)
		psd = callOctave("pyulear",x,poles,freq,Fs,range)
		elseif(lhs==2)
		[psd,f_out] = callOctave("pyulear",x,poles,freq,Fs,range)
		else
		error("Wrong number of output argments.")
	       	end
	case 6 then
		if(lhs==1)
		psd = callOctave("pyulear",x,poles,freq,Fs,range,method)
		elseif(lhs==2)
		[psd,f_out] = callOctave("pyulear",x,poles,freq,Fs,range,method)
		else
		error("Wrong number of output argments.")
	       	end
	case 7 then
		if(lhs==1)
		psd = callOctave("pyulear",x,poles,freq,Fs,range,method,plot_type)
		elseif(lhs==2)
		[psd,f_out] = callOctave("pyulear",x,poles,freq,Fs,range,method,plot_type)
		else
		error("Wrong number of output argments.")
	       	end

	end
endfunction

