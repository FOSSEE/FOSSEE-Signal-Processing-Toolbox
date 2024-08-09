function varargout = tfestimate(varargin)
//Estimate transfer function of system with input x and output y. Use the Welch (1967) periodogram/FFT method.
//This function depends on pwelch (and hence, fft1).
//Calling Sequence:
//tfestimate (x, y)
//tfestimate (x, y, window)
//tfestimate (x, y, window, overlap)
//tfestimate (x, y, window, overlap, Nfft)
//tfestimate (x, y, window, overlap, Nfft, Fs)
//tfestimate (x, y, window, overlap, Nfft, Fs, range)
//Parameters:
//x: system-input time-series data. Real pr complex vector.
//y: system-output time-series data. Real or complex vector, same dimension as x.
//window: [real vector] of window-function values between 0 and 1; the data segment has the same length as the window. Default window shape is Hamming.
//[integer scalar] length of each data segment. The default value is window=sqrt(length(x)) rounded up to the nearest integer power of 2. 
// overlap: [real scalar] segment overlap expressed as a multiple of window or segment length. 0 <= overlap < 1, The default is overlap = 0.5.
// Nfft: [integer scalar] Length of FFT.  The default is the length of the "window" vector or has the same value as the scalar "window" argument. 
//If Nfft is larger than the segment length, "seg_len", the data segment is padded with "Nfft-seg_len" zeros.  The default is no padding. Nfft values smaller than the length of the data segment (or window) are ignored silently.
// Fs: [real scalar] sampling frequency (Hertz); default = 1.0
// range: 'half', 'onesided' : frequency range of the spectrum is zero up to but not including Fs/2. Power from negative frequencies is added to the positive side of the spectrum,
//but not at zero or Nyquist (Fs/2) frequencies.  This keeps power equal in time and spectral domains. 'whole', 'twosided': frequency range of the spectrum is  -Fs/2 to Fs/2, with negative frequencies stored in "wrap around" order after the positive frequencies; e.g. frequencies for a 10-point 'twosided' spectrum are 0 0.1 0.2 0.3 0.4 0.5 -0.4 -0.3 -0.2 -0.1 'shift', 'centerdc' : same as 'whole' but with the first half of the spectrum swapped with second half to put the zero-frequency value in the middle. If data (x and y) are real, the default range is 'half', otherwise default range is 'whole'.
//Description:
//Estimate transfer function of system with input x and output y. Use the Welch (1967) periodogram/FFT method.
//Examples:
//[Pxx, freq] = tfestimate([1 2 3], [4 5 6])
//Pxx =
//   1.7500 + 0.0000i
//   1.5947 + 0.3826i
//   1.2824 + 0.0000i
//
//freq =
//   0.00000
//   0.25000
//   0.50000

  funcprot(0);
  if (nargin() < 2 || nargin() > 7)
    error("Wrong number of input arguments.");
  end
  nvarargin = length(varargin);
  for iarg = 1:nvarargin
    arg = varargin(iarg);
    if ( ~isempty(arg) && (type(arg) == 10) && ( ~strcmp(arg,'power') || ~strcmp(arg,'cross') || ~strcmp(arg,'trans') || ~strcmp(arg,'coher') || ~strcmp(arg,'ypower') ))
      varargin(iarg) = [];
    end
  end
  varargin(nvarargin + 1) = 'trans';

  if (nargout() == 0)
    pwelch(varargin(:));
  elseif (nargout() == 1)
    Pxx = pwelch(varargin(:));
    varargout(1) = Pxx;
  elseif (nargout() >= 2)
    [Pxx,f] = pwelch(varargin(:));
    varargout(1) = Pxx;
    varargout(2) = f;
  end

endfunction

//tests:
//assert_checkerror("tfestimate(1)", "Wrong number of input arguments.");
//assert_checkerror("tfestimate(1, 2, 3, 4, 5, 6, 7, 8)", "Wrong number of input arguments.");
//tfestimate([1 2 3], [4 5 6]);
//tfestimate([-1 -2 -3], [4 5 6], 'power');
//tfestimate([-1; -2; -3], [-4 -5 -6], 'power', 'cross');
//y = tfestimate([1; 2; 3], [4; 5; 6], 'coher', 'trans');
//assert_checkalmostequal(y, [1.75; 1.59472+0.38256*%i; 1.28235], 5*10^-5);
//[a b] = tfestimate([1 -2 -3], [4; 5; 6], 'ypower', 'trans');
//assert_checkalmostequal(a, [-1.1667; -1.1029-0.1912*%i; -1.5797], 5*10^-4);
//assert_checkalmostequal(b, [0; 0.25; 0.5], %eps);
//tfestimate([5-1 4+2*%i 4 -1-3*%i], [1+%i -5*%i 6 -6]);
