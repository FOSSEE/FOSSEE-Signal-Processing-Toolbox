/*Calling Sequence
   [Pxx, freq] = cpsd (x, y)
   […] = cpsd (x, y, window)
   […] = cpsd (x, y, window, overlap)
   […] = cpsd (x, y, window, overlap, Nfft)
   […] = cpsd (x, y, window, overlap, Nfft, Fs)
   […] = cpsd (x, y, window, overlap, Nfft, Fs, range)
   cpsd (…)
Estimate cross power spectrum of data x and y by the Welch (1967) periodogram/FFT method.
See "help pwelch" for description of arguments, hints and references
*/
function varargout = cpsd(varargin)
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

