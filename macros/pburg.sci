function [psd,f_out] = pburg(x, poles, varargin)
// Calculate Burg maximum-entropy power spectral density.
//
// Syntax
//   [psd, f_out] = pburg(x, poles, freq, Fs, range, method, plot_type, criterion)
//
// Parameters
// x: Sampled data (vector).
// poles: Required number of poles of the AR model (integer scalar).
// freq: Frequencies at which power spectral density is calculated (real vector or integer scalar). Default is 256.
// Fs: Sampling frequency in Hertz (real scalar). Default is 1.
// range: Frequency range of the spectrum ('half', 'onesided', 'whole', 'twosided', 'shift', or 'centerdc').
// method: Method to calculate power spectral density ('fft' or 'poly'). Default is 'poly'.
// plot_type: Type of plot ('plot', 'semilogx', 'semilogy', 'loglog', 'squared', or 'db'). Default is 'plot'.
// criterion: Model-selection criterion ('AKICc', 'KIC', 'AICc', 'AIC', or 'FPE'). Optional.
//
// Description
// The `pburg` function calculates the power spectral density (PSD) of a signal using the Burg method. 
// It is a wrapper for `arburg` and `ar_psd`. The function supports various options for frequency range, 
// computation method, and plotting.
//
// Examples
// x = [1.0, -1.6216505, 1.1102795, -0.4621741, 0.2075552, -0.018756746]
// [psd, f_out] = pburg(x, 2)
//


  funcprot(0);
  if (nargin < 2)
    error('pburg: need at least 2 args.');
  end
  nvarargin = length(varargin);
  criterion = [];
  for iarg = 1:nvarargin
    arrgh = varargin(iarg);
    if (type(arrgh) == 10 && ( ~strcmp(arrgh,'AKICc') ||...
        ~strcmp(arrgh,'KIC') || ~strcmp(arrgh,'AICc') ||...
        ~strcmp(arrgh,'AIC') || ~strcmp(arrgh,'FPE') ) )
      criterion = arrgh;
      if (nvarargin > 1)
        varargin(iarg) = [];
      else
        varargin = list();
      end
    end
  end
  [ar_coeffs,residual] = arburg(x,poles,criterion);
  if (nargout == 0)
    ar_psd(ar_coeffs,residual,varargin(:));
  elseif (nargout == 1)
    psd = ar_psd(ar_coeffs,residual,varargin(:));
  elseif (nargout >= 2)
    [psd,f_out] = ar_psd(ar_coeffs,residual,varargin(:));
  end

endfunction

//tests:

//fs = 1000;
//t = 0:1/fs:1-1/fs;
//x = cos(2*%pi*100*t);
//order = 4;
//[pxx, f] = pburg(x, order, [], fs);
//figure;
//plot(f, 10*log10(pxx));
//title('PSD Estimate using Burg Method - Sinusoidal Signal');
//xlabel('Frequency (Hz)');
//ylabel('Power/Frequency (dB/Hz)');

//fs = 1000;
//t = 0:1/fs:1-1/fs;
//x = cos(2*%pi*100*t);
//orders = [2, 4, 8, 16];
//figure;
//for i = 1:length(orders)
//    order = orders(i);
//    [pxx, f] = pburg(x, order, [], fs);
//    subplot(length(orders), 1, i);
//    plot(f, 10*log10(pxx));
//    title(['PSD Estimate using Burg Method - Order ' string(order)]);
//    xlabel('Frequency (Hz)');
//    ylabel('Power/Frequency (dB/Hz)');
//end

//fs = 1000;
//t = 0:1/fs:0.1-1/fs;
//x = cos(2*%pi*100*t);
//order = 4;
//[pxx, f] = pburg(x, order, [], fs);
//figure;
//plot(f, 10*log10(pxx));
//title('PSD Estimate using Burg Method - Short Data Segment');
//xlabel('Frequency (Hz)');
//ylabel('Power/Frequency (dB/Hz)');

//fs = 1000;
//t = 0:1/fs:1-1/fs;
//x = cos(2*%pi*100*t) + cos(2*%pi*200*t);
//order = 4;
//[pxx, f] = pburg(x, order, [], fs);
//figure;
//plot(f, 10*log10(pxx));
//title('PSD Estimate using Burg Method - Multicomponent Signal');
//xlabel('Frequency (Hz)');
//ylabel('Power/Frequency (dB/Hz)');
