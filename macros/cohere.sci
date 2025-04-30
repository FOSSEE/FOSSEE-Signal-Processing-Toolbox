function varargout = cohere(varargin)
// Estimate the coherence of signals using the Welch method.
//
// Syntax
//   [Pxx, freq] = cohere(x, y, Nfft, Fs, window, overlap, range, plot_type, detrend)
//
// Parameters
// x, y: Vectors. Input signals for coherence estimation.
// Nfft: Integer. Number of FFT points.
// Fs: Real scalar. Sampling frequency.
// window: Vector. Windowing function applied to each segment.
// overlap: Integer. Number of overlapping samples between segments.
// range: String. Frequency range for the analysis.
// plot_type: String. Type of plot to generate.
// detrend: String. Method for removing trends from the data.
// Pxx: Vector. Coherence estimate.
// freq: Vector. Frequency values corresponding to the coherence estimate.
//
// Description
// This function estimates the coherence (mean square) of signals `x` and `y` using the Welch periodogram/FFT method. It is compatible with Matlab R11 `cohere` and earlier versions.
//
// Examples
// [Pxx, freq] = cohere(x, y, 256, 1000, hamming(256), 128, 'onesided', 'plot', 'none')

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


