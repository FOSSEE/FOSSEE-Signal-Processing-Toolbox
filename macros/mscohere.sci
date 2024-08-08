/*Description:
Estimate (mean square) coherence of signals x and y. Use the Welch (1967) periodogram/FFT method.
Calling Sequence:
        [Pxx, freq] = mscohere (x, y) 
        […] = mscohere (x, y, window) 
        […] = mscohere (x, y, window, overlap) 
        […] = mscohere (x, y, window, overlap, Nfft) 
        […] = mscohere (x, y, window, overlap, Nfft, Fs) 
        […] = mscohere (x, y, window, overlap, Nfft, Fs, range) 
        mscohere (…)
See "help pwelch" for description of arguments, hints and references
Dependencies : pwelch
*/
function varargout = mscohere(varargin)
    // Check fixed argument
    if (nargin < 2 || nargin > 7)
      error("Invalid number of arguments");
    end
    nvarargin = length(varargin);
    // remove any pwelch RESULT args and add 'cross'
    for iarg=1:nvarargin
      arg = varargin(iarg);
      if ( ~isempty(arg) && ( type(arg) == 10 ) && ( ~strcmp(arg,'power') || ...
             ~strcmp(arg,'cross') || ~strcmp(arg,'trans') || ...
             ~strcmp(arg,'coher') || ~strcmp(arg,'ypower') ))
        varargin(iarg) = [];
      end
    end
    varargin(nvarargin+1) = 'coher';
    disp(varargin)
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

