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

// Example usage of freqz in different formats:
// [h, w] = freqz (b, a, n, "whole")
// [h, w] = freqz (b)
// [h, w] = freqz (b, a)
// [h, w] = freqz (b, a, n)
// h = freqz (b, a, w)
// [h, w] = freqz (…, Fs)
// freqz (...)

/*
Return the complex frequency response `h` of the rational IIR filter whose 
numerator and denominator coefficients are `b` and `a`, respectively.

The response is evaluated at `n` angular frequencies between 0 and 2*pi.

The output value `w` is a vector of the frequencies.

If `a` is omitted, the denominator is assumed to be 1 (this corresponds to a simple FIR filter).

If `n` is omitted, a value of 512 is assumed. For fastest computation, `n` should factor into a small number of small primes.

If the fourth argument, "whole", is omitted, the response is evaluated at frequencies between 0 and pi.

freqz (b, a, w)

Evaluate the response at the specific frequencies in the vector `w`. The values for `w` are measured in radians.

[...] = freqz (…, Fs)

Return frequencies in Hz instead of radians assuming a sampling rate `Fs`. If you are evaluating the response at specific frequencies `w`, those frequencies should be requested in Hz rather than radians.

freqz (...)

Plot the magnitude and phase response of `h` rather than returning them.
*/
// Dependencies
// fft1 unwrap2 postpad 
function [h_r, f_r] = freqz (b, a, n, region, Fs)

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
