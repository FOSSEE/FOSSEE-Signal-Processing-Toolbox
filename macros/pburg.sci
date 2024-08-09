function [psd,f_out] = pburg(x, poles, varargin)
//Calculate Burg maximum-entropy power spectral density.

//Calling Sequence:
//[psd,f_out] = pburg(x, poles, freq, Fs, range, method, plot_type, criterion)

//Parameters:
//All but the first two parameters are optional and may be empty.
//
//x- [vector] sampled data
//poles- [integer scalar] required number of poles of the AR model
//freq- [real vector] frequencies at which power spectral density is calculated.
//[integer scalar] number of uniformly distributed frequency values at which spectral density is calculated. [default=256]
//Fs:[real scalar] sampling frequency (Hertz) [default=1]
//
//CONTROL-STRING ARGUMENTS -- each of these arguments is a character string.
//Control-string arguments can be in any order after the other arguments.
//
//range:
//'half', 'onesided'- frequency range of the spectrum is from zero up to but not including sample_f/2.  Power
//from negative frequencies is added to the positive side of the spectrum.
//'whole', 'twosided'- frequency range of the spectrum is -sample_f/2 to sample_f/2, with negative frequencies
//stored in "wrap around" order after the positive frequencies; e.g. frequencies for a 10-point 'twosided'
//spectrum are 0 0.1 0.2 0.3 0.4 0.5 -0.4 -0.3 -0.2 -0.1
//'shift', 'centerdc'- same as 'whole' but with the first half of the spectrum swapped with second half to put the
//zero-frequency value in the middle. If "freq" is vector, 'shift' is ignored. If model coefficients "ar_coeffs" are real, the default
//range is 'half', otherwise default range is 'whole'.
//
//method:
//'fft'- use FFT to calculate power spectral density.
//'poly'- calculate spectral density as a polynomial of 1/z N.B. this argument is ignored if the "freq" argument is a
//vector.  The default is 'poly' unless the "freq" argument is an integer power of 2.
//
//plot_type: 'plot', 'semilogx', 'semilogy', 'loglog', 'squared' or 'db'- specifies the type of plot.  The default is 'plot', which
//means linear-linear axes. 'squared' is the same as 'plot'. 'dB' plots "10*log10(psd)".  This argument is ignored and a
//spectrum is not plotted if the caller requires a returned value.
//
//criterion: [optional string arg]  model-selection criterion.  Limits the number of poles so that spurious poles are not
//added when the whitened data has no more information in it (see Kay & Marple, 1981). Recognized values are-
//'AKICc' -- approximate corrected Kullback information criterion (recommended),
//'KIC'  -- Kullback information criterion
//'AICc' -- corrected Akaike information criterion
//'AIC'  -- Akaike information criterion
//'FPE'  -- final prediction error" criterion
//
//The default is to NOT use a model-selection criterion
//
// RETURNED VALUES:
//If return values are not required by the caller, the spectrum is plotted and nothing is returned.
//psd: [real vector] power-spectral density estimate.
//f_out: [real vector] frequency values.

//Description:
//This function is a wrapper for arburg and ar_psd.

//Examples:
//a = [1.0 -1.6216505 1.1102795 -0.4621741 0.2075552 -0.018756746];
//[psd, f_out] = pburg(a, 2);

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
