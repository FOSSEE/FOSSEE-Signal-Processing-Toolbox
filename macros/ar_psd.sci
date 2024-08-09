function varargout = ar_psd(a, v, varargin)
//Calculate the power spectrum of the autoregressive model.

//Calling Sequence:
// [psd, f_out] = ar_psd(a, v)
// [psd, f_out] = ar_psd (a, v, freq)
// [psd, f_out] = ar_psd (a, v, freq, fs)
// [psd, f_out] = ar_psd (..., range)
// [psd, f_out] = ar_psd (..., method)
// [psd, f_out] = ar_psd (..., plottype)

//Parameters:
//Every parameter except for the first two is optional.
//
//a- List of m=(order + 1) autoregressive model coefficients. The first element of "ar_coeffs" is the zero-lag coefficient, which always has a value of 1.
//v- Square of the moving-average coefficient of the AR model.
//freq: Frequencies at which power spectral density is calculated, or a scalar indicating the number of uniformly distributed frequency values at which spectral density is calculated.  (default = 256)
//fs- Sampling frequency (Hertz) (default=1)
//range- 'half', 'onesided'- frequency range of the spectrum is from zero up to but not including sample_f/2. Power from negative frequencies is added to the positive side of the spectrum
//'whole', 'twosided'- frequency range of the spectrum is-sample_f/2 to sample_f/2, with negative frequencies stored in "wrap around" order after the positive frequencies; e.g. frequencies for a 10-point 'twosided' spectrum are 0 0.1 0.2 0.3 0.4 0.5 -0.4 -0.3 -0.2 -0.1
//'shift', 'centerdc'- same as 'whole' but with the first half of the spectrum swapped with second half to put the zero-frequency value in the middle. If "freq" is vector, 'shift' is ignored. If model coefficients "ar_coeffs" are real, the default range is 'half', otherwise default range is 'whole'.
//Method-
//'fft'- use fft to calculate power spectrum.
//'poly'- calculate power spectrum as a polynomial of 1/z N.B. this argument is ignored if the "freq" argument is a vector. The default is 'poly' unless the "freq" argument is an integer power of 2.
//Plot type- 'plot', 'semilogx', 'semilogy', 'loglog', 'squared' or 'db': specifies the type of plot. The default is 'plot', which means linear-linear axes.
//'squared' is the same as 'plot'.  'dB' plots "10*log10(psd)".  This argument is ignored and a spectrum is not plotted if the caller requires a returned value.
//psd: estimate of power-spectral density.
//f_out: frequency values.

//Description:
//If the 'freq' argument is a vector (of frequencies) the spectrum is calculated using the polynomial method and the METHOD argument is ignored.  For scalar 'freq', an integer power of 2, or method = "fft", causes the spectrum to be calculated by fft. Otherwise, the spectrum is calculated as a polynomial.  It may be computationally more efficient to use the fft methodif length of the model is not much smaller than the number of frequency values. The spectrum is scaled so that spectral energy (area under spectrum) is the same as the time-domain energy (mean square of the signal).

//Examples:
//[a,b]= ar_psd([1,2,3], 2)

  funcprot(0);
  // Check fixed arguments
  if nargin < 2 then
    error("ar_psd: needs at least 2 args. Use help ar_psd.");
  elseif ~isvector(a) | length(a) < 2 then
    error("ar_psd: arg 1 (a) must be vector, length >= 2.");
  elseif ~isscalar(v) then
    error("ar_psd: arg 2 (v) must be real scalar >0.");
  else
    real_model = isreal(a);
    // Default values for optional arguments
    freq = 256;
    user_freqs = 0; // Boolean: true for user-specified frequencies
    Fs = 1.0;
    // FFT padding factor (is also frequency range divisor): 1=whole, 2=half.
    pad_fact = 1 + real_model;
    do_shift = 0;
    force_FFT = 0;
    force_poly = 0;
    plot_type = 1;
    // Decode and check optional arguments
    end_numeric_args = 0;
    for iarg = 1:length(varargin)
      arg = varargin(iarg);
      end_numeric_args = end_numeric_args | (type(arg) == 10);
      // Skip empty arguments
      if isempty(arg) then
        // Do nothing
      elseif (type(arg) ~= 10) then
        if end_numeric_args then
          error("ar_psd: control arg must be string.");
        // First optional numeric arg is "freq"
        elseif iarg == 1 then
          user_freqs = isvector(arg) & length(arg) > 1;
          if ~isscalar(arg) & ~user_freqs then
            error("ar_psd: arg 3 (freq) must be vector or scalar.");
          elseif ~user_freqs & (~isreal(arg) | fix(arg) ~= arg | arg <= 2 | arg >= 1048576) then
            error("ar_psd: arg 3 (freq) must be integer >=2, <=1048576");
          elseif user_freqs & ~isreal(arg) then
            error("ar_psd: arg 3 (freq) vector must be real.");
          end
          freq = arg(:); // -> column vector
        // Second optional numeric arg is "Fs" - sampling frequency
        elseif iarg == 2 then
          if ~isscalar(arg) | ~isreal(arg) | arg <= 0 then
            error("ar_psd: arg 4 (Fs) must be real positive scalar.");
          end
          Fs = arg;
        else
          error("ar_psd: control arg must be string.");
        end
      // Decode control-string arguments
      elseif ~strcmp(arg, "plot") | ~strcmp(arg, "squared") then
        plot_type = 1;
      elseif ~strcmp(arg, "semilogx") then
        plot_type = 2;
      elseif ~strcmp(arg, "semilogy") then
        plot_type = 3;
      elseif ~strcmp(arg, "loglog") then
        plot_type = 4;
      elseif ~strcmp(arg, "dB") then
        plot_type = 5;
      elseif ~strcmp(arg, "fft") then
        force_FFT = 1;
        force_poly = 0;
      elseif ~strcmp(arg, "poly") then
        force_FFT = 0;
        force_poly = 1;
      elseif ~strcmp(arg, "half") | ~strcmp(arg, "onesided") then
        pad_fact = 2; // FFT zero-padding factor (pad FFT to double length)
        do_shift = 0;
      elseif ~strcmp(arg, "whole") | ~strcmp(arg, "twosided") then
        pad_fact = 1; // FFT zero-padding factor (do not pad)
        do_shift = 0;
      elseif ~strcmp(arg, "shift") | ~strcmp(arg, "centerdc") then
        pad_fact = 1;
        do_shift = 1;
      else
        error("ar_psd: string arg: illegal value: %s", arg);
      end
    end
    // End of decoding and checking args
    if user_freqs then
      // User provides (column) vector of frequencies
      if or(abs(freq) > Fs/2) then
        error("ar_psd: arg 3 (freq) cannot exceed half sampling frequency.");
      elseif pad_fact == 2 & or(freq < 0) then
        error("ar_psd: arg 3 (freq) must be positive in onesided spectrum");
      end
      freq_len = length(freq);
      fft_len = freq_len;
      use_FFT = 0;
      do_shift = 0;
    else
      // Internally generated frequencies
      freq_len = freq;
      freq = (Fs / pad_fact / freq_len) * (0:freq_len - 1)';
      // Decide which method to use (poly or FFT)
      is_power_of_2 = modulo(log(freq_len), log(2)) < 10 * %eps;
      use_FFT = (~force_poly & is_power_of_2) | force_FFT;
      fft_len = freq_len * pad_fact;
    end
    // Calculate denominator of Equation 2.28, Kay and Marple, ref [1] Jr.:
    len_coeffs = length(a);
    if use_FFT then
      // FFT method
      x = [a(:); zeros(fft_len - len_coeffs, 1)];
      fft_out = fft(x);
    else
      // Polynomial method
      // Complex data on "half" frequency range needs -ve frequency values
      if pad_fact == 2 & ~real_model then
        freq = [freq; -freq(freq_len:-1:1)];
        fft_len = 2 * freq_len;
      end
      fft_out = horner(a($:-1:1), exp((-%i * 2 * %pi / Fs) * freq));
    end
    // The power spectrum (PSD) is the scaled squared reciprocal of amplitude
    // of the FFT/polynomial. This is NOT the reciprocal of the periodogram.
    // The PSD is a continuous function of frequency. For uniformly
    // distributed frequency values, the FFT algorithm might be the most
    // efficient way of calculating it.
    psd = (v / Fs) ./ (fft_out .* conj(fft_out));
    // Range='half' or 'onesided',
    // Add PSD at -ve frequencies to PSD at +ve frequencies
    // N.B. unlike periodogram, PSD at zero frequency _is_ doubled.
    if pad_fact == 2 then
      freq = freq(1:freq_len);
      if real_model then
        // Real data, double the psd
        psd = 2 * psd(1:freq_len);
      elseif use_FFT then
        // Complex data, FFT method, internally-generated frequencies
        psd = psd(1:freq_len) + [psd(1); psd(fft_len:-1:freq_len + 2)];
      else
        // Complex data, polynomial method
        // User-defined and internally-generated frequencies
        psd = psd(1:freq_len) + psd(fft_len:-1:freq_len + 1);
      end
    // Range='shift'
    // Disabled for user-supplied frequencies
    // Shift zero-frequency to the middle (pad_fact == 1)
    elseif do_shift then
      len2 = fix((fft_len + 1) / 2);
      psd = [psd(len2 + 1:fft_len); psd(1:len2)];
      freq = [freq(len2 + 1:fft_len) - Fs; freq(1:len2)];
    end
    // Plot the spectrum if there are no return variables.
    if nargout() >= 2 then
      varargout(1) = psd;
      varargout(2) = freq;
    elseif nargout() == 1 then
      varargout(1) = psd;
    else
      if plot_type == 1 then
        plot(freq, psd);
      elseif plot_type == 2 then
        semilogx(freq, psd);
      elseif plot_type == 3 then
        semilogy(freq, psd);
      elseif plot_type == 4 then
        loglog(freq, psd);
      elseif plot_type == 5 then
        plot(freq, 10 * log10(psd));
      end
    end
  end
endfunction

//tests:

//a = [1, -0.5];
////v = 1;
//[psd, freq] = ar_psd(a, v);
//plot(freq, psd);
//title('Power Spectral Density of the AR Model');
//xlabel('Frequency');
//ylabel('Power/Frequency');

//a = [1, -1.5, 0.7];
//v = 2;
//Fs = 2.0;
//[psd, freq] = ar_psd(a, v, 512, Fs);
//plot(freq, psd);
//title('Power Spectral Density with Different Sampling Frequency');
//xlabel('Frequency (Hz)');
//ylabel('Power/Frequency');

//a = [1, -0.9, 0.4];
//v = 0.8;
//Fs = 1.0;
//ar_psd(a, v, 512, Fs, 'semilogx');
//title('Power Spectral Density (Semilogx)');
//xlabel('Frequency (Hz)');
//ylabel('Power/Frequency');
//
//figure();
//ar_psd(a, v, 512, Fs, 'loglog');
//title('Power Spectral Density (Loglog)');
//xlabel('Frequency (Hz)');
//ylabel('Power/Frequency');

//a = [1, -0.7, 0.2];
//v = 1.5;
//Fs = 1.0;
//[psd_fft, freq] = ar_psd(a, v, 512, Fs, 'fft');
//[psd_poly, freq] = ar_psd(a, v, 512, Fs, 'poly');
//plot(freq, psd_fft, 'r', freq, psd_poly, 'b');
//title('Power Spectral Density (FFT vs Polynomial)');
//xlabel('Frequency (Hz)');
//ylabel('Power/Frequency');
//legend('FFT Method', 'Polynomial Method');

//a = [1, -1.2, 0.5];
//v = 1;
//[psd_half, freq_half] = ar_psd(a, v, 512, 1, 'half');
//[psd_whole, freq_whole] = ar_psd(a, v, 512, 1, 'whole');
//subplot(2, 1, 1);
//plot(freq_half, psd_half);
//title('Power Spectral Density (Half Spectrum)');
//xlabel('Frequency (Hz)');
//ylabel('Power/Frequency');
//
//subplot(2, 1, 2);
//plot(freq_whole, psd_whole);
//title('Power Spectral Density (Whole Spectrum)');
//xlabel('Frequency (Hz)');
//ylabel('Power/Frequency');
