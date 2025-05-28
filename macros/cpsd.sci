function varargout = cpsd(varargin)
// Estimate the cross power spectrum of data using the Welch method.
//
// Syntax
//   [Pxx, freq] = cpsd(x, y)
//   [...] = cpsd(x, y, window)
//   [...] = cpsd(x, y, window, overlap)
//   [...] = cpsd(x, y, window, overlap, Nfft)
//   [...] = cpsd(x, y, window, overlap, Nfft, Fs)
//   [...] = cpsd(x, y, window, overlap, Nfft, Fs, range)
//   cpsd(...)
//
// Parameters
// x, y: Vectors. Input signals for cross power spectrum estimation.
// window: Vector. Windowing function applied to each segment.
// overlap: Integer. Number of overlapping samples between segments.
// Nfft: Integer. Number of FFT points.
// Fs: Real scalar. Sampling frequency.
// range: String. Frequency range for the analysis.
// Pxx: Vector. Cross power spectrum estimate.
// freq: Vector. Frequency values corresponding to the cross power spectrum estimate.
//
// Description
// This function estimates the cross power spectrum of data `x` and `y` using the Welch periodogram/FFT method. It is compatible with Matlab's `cpsd` function.
//
// Examples
// t = linspace(0,10,1000); 
// x = sin(t) ;
// y = cos(t);
// cpsd(x,y)


    // Check fixed argument
    if (nargin < 2 || nargin > 7)
      error( "Invalid number of inputs" );
    end
    nvarargin = length(varargin);
    // remove any pwelch RESULT args and add 'cross'
    for iarg=1:nvarargin
      arg = varargin(iarg);
      if ( ~isempty(arg) && (type(arg) == 10 ) && ( ~strcmp(arg,'power') || ...
             ~strcmp(arg,'cross') || ~strcmp(arg,'trans') || ...
             ~strcmp(arg,'coher') || ~strcmp(arg,'ypower') ))
        varargin(iarg) = [];
      end
    end
    varargin(nvarargin+1) = 'cross';
    if ( nargout==0 )
      pwelch(varargin(:));
    elseif ( nargout==1 )
      Pxx = pwelch(varargin(:));
      varargout(1) = Pxx;
    elseif ( nargout>=2 )
      [Pxx,f] = pwelch(varargin(:));
      varargout(1) = Pxx;
      varargout(2) = f;
    end
  endfunction

