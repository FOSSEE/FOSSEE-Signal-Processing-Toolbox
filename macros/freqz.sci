// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/signal/
// Modifieded by: Abinash Singh , Under FOSSEE Internship
// Last Modified on : 3 Feb 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

function [h_r, f_r] = freqz (b, a, n, region, Fs)
// Compute the frequency response of a digital filter.
//
// Syntax
//   [h, w] = freqz(b, a)
//   [h, w] = freqz(b, a, n)
//   [h, w] = freqz(b, a, n, "whole")
//   [h, w] = freqz(b, a, w)
//   [h, f] = freqz(b, a, n, Fs)
//   freqz(b, a, n)
//   freqz(b, a)
//
// Parameters
// b: Vector. The numerator coefficients of the filter's transfer function.
// a: Vector. The denominator coefficients of the filter's transfer function. If omitted, it is assumed to be 1 (FIR filter).
// n: Integer (optional). The number of frequency points. Default is 512.
// w: Vector (optional). Specific frequencies (in radians) at which to evaluate the response.
// Fs: Positive scalar (optional). Sampling frequency in Hz. If provided, frequencies are returned in Hz instead of radians.
// h: Vector. The complex frequency response of the filter.
// w: Vector. The frequencies (in radians) at which the response is evaluated.
// f: Vector. The frequencies (in Hz) at which the response is evaluated.
//
// Description
// This function computes the frequency response of a digital filter defined by its numerator (`b`) and denominator (`a`) coefficients. The response can be evaluated at a specified number of points (`n`) or at specific frequencies (`w`). If the sampling frequency (`Fs`) is provided, the frequencies are returned in Hz.
//
// - If `a` is omitted, the filter is assumed to be an FIR filter.
// - If `n` is omitted, a default value of 512 is used.
// - If the "whole" option is specified, the response is evaluated over the entire Nyquist range (0 to 2π). Otherwise, it is evaluated over half the Nyquist range (0 to π).
// - If no output arguments are provided, the function plots the magnitude and phase response.
//
// Examples
// // Compute the frequency response of an FIR filter:
//    b = [0.2929, 0.5858, 0.2929];
//    [h, w] = freqz(b)
//
// // Compute the frequency response of an IIR filter:
//    b = [0.2929, 0.5858, 0.2929];
//    a = [1, 0, 0.1716];
//    [h, w] = freqz(b, a)
//
// // Compute the response at specific frequencies:
//    b = [0.2929, 0.5858, 0.2929];
//    a = [1, 0, 0.1716];
//    w = linspace(0, pi, 100);
//    h = freqz(b, a, w)
//
// // Compute the response with a sampling frequency:
//    b = [0.2929, 0.5858, 0.2929];
//    a = [1, 0, 0.1716];
//    [h, f] = freqz(b, a, 512, 1000)
//
// // Plot the magnitude and phase response:
//    b = [0.2929, 0.5858, 0.2929];
//    freqz(b)
//
// See also
// fft1
// unwrap2 
// postpad 
// 

  if (nargin < 1)
    error("Invalid numbers of inputs");
  elseif (nargin == 1)
    // Response of an FIR filter.
    a = []; 
    n = [];
    region =[];
    Fs = [];
  elseif (nargin == 2)
    // Response of an IIR filter
    n = [];
    region = []; 
    Fs = [];
  elseif (nargin == 3)
    region =[]; 
    Fs = [];
  elseif (nargin == 4)
    Fs = [];
    if (~ (type(region)==10) && ~ isempty(region))
      Fs = region;
      region = [];
    end
  end

  if (isempty (b))
    b = 1;
  elseif (~ isvector (b))
    error ("freqz: B must be a vector");
  end
  if (isempty (a))
    a = 1;
  elseif (~ isvector (a))
    error ("freqz: A must be a vector");
  end
  if (isempty (n))
    n = 512;
  elseif (isscalar (n) && n < 1)
    error ("freqz: N must be a positive integer");
  end
  if (isempty (region))
    if (isreal (b) && isreal (a))
      region = "half";
    else
      region = "whole";
    end
  end
  if (isempty (Fs))
    freq_norm = %t;
    if (nargout == 1)
      Fs = 2;
    else
      Fs = 2*%pi;
    end
  else
    freq_norm = %f;
  end
  // FIXME : nargout != 0 even if no output parameter is used
  // FIXME : problem in argn() or nargin function
  //plot_output = (nargout == 0);
  plot_output = (nargout == 1) // temp fix
  whole_region = ~strcmp (region, "whole");

  a = a(:);
  b = b(:);

  if (~ isscalar (n))
    // Explicit frequency vector given
    w = n; 
    f = n;
    if (nargin == 4)
      // Sampling rate Fs was specified
      w = 2*%pi*f/Fs;
    end
    k = max (length (b), length (a));
    hb = polyval (postpad (b, k), exp (%i*w));
    ha = polyval (postpad (a, k), exp (%i*w));
  else
    // polyval(fliplr(P),exp(jw)) is O(p n) and fft(x) is O(n log(n)),
    // where p is the order of the polynomial P.  For small p it
    // would be faster to use polyval but in practice the overhead for
    // polyval is much higher and the little bit of time saved isn't
    // worth the extra code.
    k = max (length (b), length (a));
    if (k > n/2 && nargout == 0)
      // Ensure a causal phase response.
      n = n * 2 .^ ceil (log2 (2*k/n));
    end

    if (whole_region)
      N = n;
      if (plot_output)
        f = Fs * (0:n).' / N;    // do 1 more for the plot
      else
        f = Fs * (0:n-1).' / N;
      end
    else
      N = 2*n;
      if (plot_output)
        n = n + 1;
      end
      f = Fs * (0:n-1).' / N;
    end

    pad_sz = N*ceil (k/N);
    b = postpad (b, pad_sz);
    a = postpad (a, pad_sz);

    hb = zeros (n, 1);
    ha = zeros (n, 1);

    for i = 1:N:pad_sz
      fftresult = fft1 (postpad (b(i:i+N-1), N))(1:n);
      if size(fftresult,1) == 1 then fftresult = fftresult';end
      hb = hb + fftresult ;
      tempfftresult=fft1 (postpad (a(i:i+N-1), N))(1:n);
      if size(tempfftresult,1) == 1 then tempfftresult = tempfftresult';end
      ha = ha + tempfftresult;
    end

  end

  h = hb ./ ha;

  if (plot_output)
    // Plot and don't return values.
    if (whole_region && isscalar (n))
      h($+1) = h(1); // Solution is periodic.  Copy first value to end.
    end
    freqz_plot (f, h, freq_norm);
  end
    // Return values and don't plot.
    h_r = h;
    f_r = f;
  

endfunction
function freqz_plot (w, h, freq_norm)
  if (nargin < 2)
    error("Invalid numbers of inputs");
  end

  if nargin < 3 then
    freq_norm = %f 
  end
  n = size(max(w));
  mag = 20 * log10 (abs (h));
  phase = unwrap2 (angle (h));

  if (freq_norm)
    x_label = 'Normalized Frequency (\times\pi rad/sample)';
  else
    x_label = "Frequency (Hz)";
  end
  subplot (2, 1, 1);
  plot (w, mag);
  xgrid;
  xlabel (x_label);
  ylabel ("Magnitude (dB)");

  subplot (2, 1, 2);
  plot (w, phase*360/(2*%pi));
  xgrid;
  xlabel (x_label);
  ylabel ("Phase (degrees)");

endfunction
/*
//  passed
testif HAVE_FFTW # correct values and fft-polyval consistency 
 // butterworth filter, order 2, cutoff pi/2 radians
 b = [0.292893218813452  0.585786437626905  0.292893218813452];
 a = [1  0  0.171572875253810];
 [h,w] = freqz (b,a,32);
 
//passed
testif HAVE_FFTW # whole-half consistency
 b = [1 1 1]/3;
 [h,w] = freqz (b,1,32,"whole");
 
 [h2,w2] = freqz (b,1,16,"half");


//passed
testif HAVE_FFTW # Sampling frequency properly interpreted
 b = [1 1 1]/3; a = [1 0.2];
 [h,f] = freqz (b,a,16,320);

 [h2,f2] = freqz (b,a,[0:15]*10,320);

 [h3,f3] = freqz (b,a,32,"whole",320);


// Test input validation
// FIXME: Need to put tests here and simplify input validation in the main code.

*/
