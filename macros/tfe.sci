function varargout = tfe(varargin)
// Estimate transfer function of system with input "x" and output "y".
// 
// Syntax
//     [Pxx,freq] = tfe(x,y,Nfft,Fs,window,overlap,range,plot_type,detrend)
//
// Description
//  Estimate transfer function of system with input "x" and output "y".
//         Use the Welch (1967) periodogram/FFT method.
//         Compatible with Matlab R11 tfe and earlier.
//         See "help pwelch" for description of arguments, hints and references — especially hint (7) for Matlab R11 defaults.
// 
// Examples
// // Estimate the transfer function of a system using tfe
//
// // Define input and output signals
// x = sin(2 * %pi * (0:0.01:10)); // Input signal (sine wave)
// y = 0.5 * x + 0.1 * rand(1, length(x)); // Output signal (scaled and noisy)
//
// // Define parameters
// Nfft = 256; // Number of FFT points
// Fs = 100; // Sampling frequency
// window = hamming(128); // Hamming window
// overlap = 64; // Overlap between segments
// range = 'onesided'; // Frequency range
// plot_type = 'trans'; // Plot type
// detrend = 'none'; // No detrending
//
// // Estimate the transfer function
// [Pxx, freq] = tfe(x, y, Nfft, Fs, window, overlap, range, plot_type, detrend);
//
// // Display the results
// disp("Transfer function estimate:");
// disp(Pxx);
// disp("Frequency vector:");
// disp(freq);
// 
// See also
// pwelch

nargout = argn (1)
    nargin = argn(2)
    // Check fixed argument
    if ( nargin<2 )
      error( 'tfe: Need at least 2 args. Use help tfe.' );
    end
    nvarargin = max(size(varargin));
    // remove any pwelch RESULT args and add 'trans'
    for iarg=1:nvarargin
      arg = varargin(iarg);
      if ( ~isempty(arg) && type(arg) == [10 ] && ( ~strcmp(arg,'power') || ...
             ~strcmp(arg,'cross') || ~strcmp(arg,'trans') || ...
             ~strcmp(arg,'coher') || ~strcmp(arg,'ypower') ))
        varargin(iarg) = [];
      end
    end
    varargin(nvarargin+1) = 'trans';
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
  endfunction


