function [Pxx, freq] = tfestimate(x, y, window, overlap, Nfft, Fs, range)

//Estimate transfer function of system with input x and output y. Use the Welch (1967) periodogram/FFT method.
//Calling Sequence
//tfestimate (x, y, window, overlap, Nfft, Fs, range)
//[Pxx, freq] = tfestimate (…)
//Parameters 
//x: Input.
//y: Output.
//window:        [real vector] of window-function values between 0 and 1; the data segment has the same length as the window. Default window shape is Hamming. [integer scalar] length of each data segment.  The default value is window=sqrt(length(x)) rounded up to the nearest integer power of 2; see 'sloppy' argument. 
// overlap:      [real scalar] segment overlap expressed as a multiple of window or segment length.   0 <= overlap < 1, The default is overlap=0.5 .
// Nfft:         [integer scalar] Length of FFT.  The default is the length of the "window" vector or has the same value as the scalar "window" argument.  If Nfft is larger than the segment length, "seg_len", the data segment is padded with "Nfft-seg_len" zeros.  The default is no padding. Nfft values smaller than the length of the data segment (or window) are ignored silently. 
// Fs:           [real scalar] sampling frequency (Hertz); default=1.0
// range:      'half',  'onesided' : frequency range of the spectrum is zero up to but not including Fs/2.  Power from negative frequencies is added to the positive side of the spectrum, but not at zero or Nyquist (Fs/2) frequencies.  This keeps power equal in time and spectral domains.  See reference [2]. 'whole', 'twosided' : frequency range of the spectrum is  -Fs/2 to Fs/2, with negative frequencies stored in "wrap around" order after the positive frequencies; e.g. frequencies for a 10-point 'twosided' spectrum are 0 0.1 0.2 0.3 0.4 0.5 -0.4 -0.3 -0.2 -0.1 'shift', 'centerdc' : same as 'whole' but with the first half of the spectrum swapped with second half to put the zero-frequency value in the middle. (See "help fftshift". If data (x and y) are real, the default range is 'half', otherwise default range is 'whole'.
//Description
//This function is being called from Octave.
//Estimate transfer function of system with input x and output y. Use the Welch (1967) periodogram/FFT method.
//Examples
//[Pxx, freq]=tfestimate ([1 2 3], [4 5 6])
//Pxx =
//
//   1.7500 + 0.0000i
//   1.5947 + 0.3826i
//   1.2824 + 0.0000i
//
//freq =
//
//   0.00000
//   0.25000
//   0.50000

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 2 | rhs > 7)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 2 then
		if(lhs==1)
		Pxx = callOctave("tfestimate",x,y)
		elseif(lhs==2)
		[Pxx, freq] = callOctave("tfestimate",x,y)
		else
		error("Wrong number of output argments.")
		end

	case 3 then
		if(lhs==1)
		Pxx = callOctave("tfestimate",x, y, window)
		elseif(lhs==2)
		[Pxx, freq] = callOctave("tfestimate",x, y, window)
		else
		error("Wrong number of output argments.")
	       	end
	case 4 then
		if(lhs==1)
		Pxx = callOctave("tfestimate",x, y, window, overlap)
		elseif(lhs==2)
		[Pxx, freq] = callOctave("tfestimate",x, y, window, overlap)
		else
		error("Wrong number of output argments.")
	       	end
	case 5 then
		if(lhs==1)
		Pxx = callOctave("tfestimate",x, y, window, overlap, Nfft)
		elseif(lhs==2)
		[Pxx, freq] = callOctave("tfestimate",x, y, window, overlap, Nfft)
		else
		error("Wrong number of output argments.")
	       	end
	case 6 then
		if(lhs==1)
		Pxx = callOctave("tfestimate",x, y, window, overlap, Nfft, Fs)
		elseif(lhs==2)
		[Pxx, freq] = callOctave("tfestimate",x, y, window, overlap, Nfft, Fs)
		else
		error("Wrong number of output argments.")
	       	end
	case 7 then
		if(lhs==1)
		Pxx = callOctave("tfestimate",x, y, window, overlap, Nfft, Fs, range)
		elseif(lhs==2)
		[Pxx, freq] = callOctave("tfestimate",x, y, window, overlap, Nfft, Fs, range)
		else
		error("Wrong number of output argments.")
	       	end
	end
endfunction


