/*
Calling Sequence
      [Pxx, freq] = cohere(x,y,Nfft,Fs,window,overlap,range,plot_type,detrend)
Estimate (mean square) coherence of signals "x" and "y".
Use the Welch (1967) periodogram/FFT method.
Compatible with Matlab R11 cohere and earlier.
See "help pwelch" for description of arguments, hints and references — especially hint (7) for Matlab R11 defaults. */
function varargout = cohere(varargin)
      if ( nargin<2 )
        error( 'cohere: Need at least 2 args. Use help cohere.' );
      end
      nvarargin = length(varargin);
      // remove any pwelch RESULT args and add 'trans'
      for iarg=1:nvarargin
        arg = varargin(iarg);
        if ( ~isempty(arg) && (type(arg)== 10) && ( ~strcmp(arg,'power') || ...
               ~strcmp(arg,'cross') || ~strcmp(arg,'trans') || ...
               ~strcmp(arg,'coher') || ~strcmp(arg,'ypower') ))
          varargin(iarg) = [];
        end
      end
      varargin(nvarargin+1) = 'coher';
      saved_compatib = pwelch('R11-');
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
      pwelch(saved_compatib);
      saved_compatib = 0;
    endfunction

   
