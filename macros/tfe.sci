function [Pxx,freqs] = tfe(x,y,Nfft,Fs,win,overlap,ran,plot_type,detrends)
//Estimate transfer function of system with input "x" and output "y". Use the Welch (1967) periodogram/FFT method.
//Calling Sequence
// [Pxx,freq] = tfe(x,y,Nfft,Fs,window,overlap,range,plot_type,detrend)
//Parameters 
//x: [non-empty vector] system-input time-series data
//y: [non-empty vector] system-output time-series data
//win:[real vector] of window-function values between 0 and 1; the data segment has the same length as the window. Default window shape is Hamming. [integer scalar] length of each data segment.  The default value is window=sqrt(length(x)) rounded up to the nearest integer power of 2; see 'sloppy' argument.
//overlap:[real scalar] segment overlap expressed as a multiple of window or segment length.   0 <= overlap < 1, The default is overlap=0.5 .
//Nfft:[integer scalar] Length of FFT.  The default is the length of the "window" vector or has the same value as the scalar "window" argument.  If Nfft is larger than the segment length, "seg_len", the data segment is padded with "Nfft-seg_len" zeros.  The default is no padding. Nfft values smaller than the length of the data segment (or window) are ignored silently.
//Fs:[real scalar] sampling frequency (Hertz); default=1.0 
//range:'half',  'onesided' : frequency range of the spectrum is zero up to but not including Fs/2.  Power from negative frequencies is added to the positive side of the spectrum, but not at zero or Nyquist (Fs/2) frequencies.  This keeps power equal in time and spectral domains.  See reference [2]. 'whole', 'twosided' : frequency range of the spectrum is-Fs/2 to Fs/2, with negative frequenciesstored in "wrap around" order after the positivefrequencies; e.g. frequencies for a 10-point 'twosided'spectrum are 0 0.1 0.2 0.3 0.4 0.5 -0.4 -0.3 -0.2 -0.1 'shift', 'centerdc' : same as 'whole' but with the first half of the spectrum swapped with second half to put the zero-frequency value in the middle. (See "help fftshift". If data (x and y) are real, the default range is 'half', otherwise default range is 'whole'.
//plot_type: 'plot', 'semilogx', 'semilogy', 'loglog', 'squared' or 'db': specifies the type of plot.  The default is 'plot', which means linear-linear axes. 'squared' is the same as 'plot'. 'dB' plots "10*log10(psd)".  This argument is ignored and a spectrum is not plotted if the caller requires a returned value.
//detrends:'no-strip', 'none' -- do NOT remove mean value from the data'short', 'mean' -- remove the mean value of each segment from each segment of the data. 'linear',-- remove linear trend from each segment of the data.'long-mean'-- remove the mean value from the data before splitting it into segments. This is the default.
//Description
//Estimate transfer function of system with input "x" and output "y". Use the Welch (1967) periodogram/FFT method.
	funcprot(0);
	rhs= argn(2);
	lhs= argn(1);
	if(rhs < 10 | rhs > 10)
		error("Wrong number of input arguments");
	end
	select(rhs)
	case 10 then
		[Pxx,freqs] = callOctave("tfe",x,y,Nfft,Fs,win,overlap,ran,plot_type,detrends);
	end
endfunction