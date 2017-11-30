function [spectra, Pxx_ci, freqn] = pwelch(x, varargin)
//Estimate power spectral density of data "x" by the Welch (1967) periodogram/FFT method.
//Calling Sequence
//[spectra,freq] = pwelch(x, window, overlap, Nfft, Fs, range, plot_type, detrend, sloppy)
//[spectra,freq] = pwelch(x, y, window, overlap, Nfft, Fs, range, plot_type, detrend, sloppy, results)
//[spectra,Pxx_ci,freq] = pwelch(x, window, overlap, Nfft, Fs, conf, range, plot_type, detrend, sloppy)
//[spectra,Pxx_ci,freq] = pwelch(x, y, window, overlap, Nfft, Fs, conf, range, plot_type, detrend, sloppy, results)
//Parameters
//x: [non-empty vector] system-input time-series data
//
//y: [non-empty vector] system-output time-series data
//
//window: [real vector] of window-function values between 0 and 1; the data segment has the same length as the window. Default window shape is Hamming. [integer scalar] length of each data segment.  The default value is window=sqrt(length(x)) rounded up to the nearest integer power of 2; see 'sloppy' argument.
//
//overlap: [real scalar] segment overlap expressed as a multiple of window or segment length. 0 <= overlap < 1, The default is overlap=0.5 .
//
//Nfft: [integer scalar] Length of FFT.  The default is the length of the "window" vector or has the same value as the scalar "window" argument.  If Nfft is larger than the segment length, "seg_len", the data segment is padded with "Nfft-seg_len" zeros.  The default is no padding. Nfft values smaller than the length of the data segment (or window) are ignored silently.
//
//Fs:[real scalar] sampling frequency (Hertz); default=1.0
//
//conf: [real scalar] confidence level between 0 and 1.  Confidence intervals of the spectral density are estimated from scatter in the periodograms and are returned as Pxx_ci. Pxx_ci(:,1) is the lower bound of the confidence interval and Pxx_ci(:,2) is the upper bound.  If there are three return values, or conf is an empty matrix, confidence intervals are calculated for conf=0.95 . If conf is zero or is not given, confidence intervals are not calculated. Confidence intervals can be obtained only for the power spectral density of x; nothing else.
//
//range: 
//'half',  'onesided' : frequency range of the spectrum is zero up to but not including Fs/2.  Power from negative frequencies is added to the positive side of the spectrum, but not at zero or Nyquist (Fs/2) frequencies.  This keeps power equal in time and spectral domains.  See reference [2]. 
//'whole', 'twosided' : frequency range of the spectrum is -Fs/2 to Fs/2, with negative frequencies stored in "wrap around" order after the positive frequencies; e.g. frequencies for a 10-point 'twosided' spectrum are 0 0.1 0.2 0.3 0.4 0.5 -0.4 -0.3 -0.2 -0.1
//'shift', 'centerdc' : same as 'whole' but with the first half of the spectrum swapped with second half to put the zero-frequency value in the middle. (See "help fftshift". If data (x and y) are real, the default range is 'half', otherwise default range is 'whole'.
//
//plot_type:  
//'plot', 'semilogx', 'semilogy', 'loglog', 'squared' or 'db': specifies the type of plot.  The default is 'plot', which means linear-linear axes. 'squared' is the same as 'plot'. 'dB' plots "10*log10(psd)".  This argument is ignored and a spectrum is not plotted if the caller requires a returned value.
//
//detrend: 'no-strip', 'none' -- do NOT remove mean value from the data 'short', 'mean' -- remove the mean value of each segment from each segment of the data.
//'linear', -- remove linear trend from each segment of the data.
//'long-mean' -- remove the mean value from the data before splitting it into segments.  This is the default.
//
//sloppy: FFT length is rounded up to the nearest integer power of 2 by zero padding.  FFT length is adjusted after addition of padding by explicit Nfft argument. The default is to use exactly the FFT and window.
//Description
//Estimate power spectral density of data "x" by the Welch (1967) periodogram/FFT method. The data is divided into segments.  If "window" is a vector, each segment has the same length as "window" and is multiplied by "window" before (optional) zero-padding and calculation of its periodogram. If "window" is a scalar, each segment has a length of "window" and a Hamming window is used. The spectral density is the mean of the periodograms, scaled so that area under the spectrum is the same as the mean square of the data.  This equivalence is supposed to be exact, but in practice there is a mismatch of up to 0.5% when comparing area under a periodogram with the mean square of the data.
funcprot(0);
rhs=argn(2);
lhs=argn(1)
if(rhs<9 | rhs>9) then
    error("Wrong number of input arguments.");
end
if(rhs<11 | rhs>11) then
    error("Wrong number of input arguments.");
end
if(lhs<2 | lhs>3) then
    error("Wrong number of output arguments.");
end
select(rhs)
case 9 then
    select(lhs)
        case 2 then
            [spectra, freqn] = callOctave("pwelch", x, varargin(1), varargin(2), varargin(3), varargin(4), varargin(5), varargin(6), varargin(7), varargin(8));
        case 3 then
            [spectra, Pxx_ci, freqn] = callOctave("pwelch", x, varargin(1), varargin(2), varargin(3), varargin(4), varargin(5), varargin(6), varargin(7), varargin(8));
    end
case 11 then
    select(lhs)
        case 2 then
            [spectra, freqn] = callOctave("pwelch", x, varargin(1), varargin(2), varargin(3), varargin(4), varargin(5), varargin(6), varargin(7), varargin(8), varargin(9), varargin(10));
        case 3 then
            [spectra, Pxx_ci, freqn] = callOctave("pwelch", x, varargin(1), varargin(2), varargin(3), varargin(4), varargin(5), varargin(6), varargin(7), varargin(8), varargin(9), varargin(10));
    end
end

endfunction
