// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Last Modified on : 3 Feb 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
/*
Calling Sequence
 [x, t] = impz (b) ¶
 [x, t] = impz (b, a) ¶
 [x, t] = impz (b, a, n) ¶
 [x, t] = impz (b, a, n, fs) ¶
 impz (…) ¶
Generate impulse-response characteristics of the filter. 
The filter coefficients correspond to the the z-plane rational function with numerator b and denominator a. If a is not specified, it defaults to 1. 
If n is not specified, or specified as [], it will be chosen such that the signal has a chance to die down to -120dB, or to not explode beyond 120dB, or to show five periods if there is no significant damping.
If no return arguments are requested, plot the results.
Dependencies
  fftfilt
*/
function [x_r, t_r] = impz(b, a, n, fs)

  if nargin < 1 || nargin > 4 then 
    error(" impz : Incorrect number of input arguments ")
  end
  if nargin < 2 then a = [1]; end 
  if nargin < 3 then n = [] ; end
  if nargin < 4 then fs = 1 ; end
  
  if  (~isvector(b) && ~isscalar(b)) || (~isvector(a) && ~isscalar(a) )  then
    error("impz: B and A must be vectors");
  end
  if isempty(n) && length(a) > 1 then 
    precision = 1e-6;
    r = roots(a);
    maxpole = max(abs(r));
    if (maxpole > 1+precision)     // unstable -- cutoff at 120 dB
      n = floor(6/log10(maxpole));
    elseif (maxpole < 1-precision) // stable -- cutoff at -120 dB
      n = floor(-6/log10(maxpole));
    else                           // periodic -- cutoff after 5 cycles
      n = 30;

      // find longest period less than infinity
      // cutoff after 5 cycles (w=10*pi)
      rperiodic = r(find(abs(r)>=1-precision & abs(arg(r))>0));
      if ~isempty(rperiodic)
        n_periodic = ceil(10*pi./min(abs(arg(rperiodic))));
        if (n_periodic > n)
          n = n_periodic;
        end
      end

      // find most damped pole
      // cutoff at -60 dB
      rdamped = r(find(abs(r)<1-precision));
      if ~isempty(rdamped)
        n_damped = floor(-3/log10(max(abs(rdamped))));
        if (n_damped > n)
          n = n_damped;
        end
      end
    end
    n = n + length(b);
  elseif isempty(n)
    n = length(b);
  elseif ( ~isscalar(n))
    // TODO: missing option of having N as a vector of values to
    //       compute the impulse response.
    error ("impz: N must be empty or a scalar");
  end

  if length(a) == 1 then 
    x = fftfilt(b/a, [1, zeros(1,n-1)]');
  else
    x = filter(b, a, [1, zeros(1,n-1)]');
  end
  t = [0:n-1]/fs;

  if nargout >= 1 x_r = x; end
  if nargout >= 2 t_r = t; end
  //if nargout ~= 2 then  //FIXME: fix nargout to detect 0 output arguments . till then plot it always
      title("Impulse Response");
      if (fs > 1000)
        t = t * 1000;
        xlabel("Time (msec)");
      else
        xlabel("Time (sec)");
      end
      plot(t, x,);
  //end

endfunction
/*

test case 1
assert_checkequal(size(impz (1, [1 -1 0.9], 100)), [100 1]) // passed

test case 2
// 7th order butterworth filter with fc = 0.5 //passed
B=[0.016565   0.115957   0.347871   0.579785   0.579785   0.347871   0.115957   0.016565];
A=[1.0000e+00  -5.6205e-16   9.1997e-01  -3.6350e-16   1.9270e-01  -4.3812e-17   7.6835e-03  -4.2652e-19];
impz(B, A) 

test case 3
// 
[x_r,tr]=impz([0.4 0.2 8 2] ,1,10)
assert_checkalmostequal(x_r,[ 0.4000000 0.2000000 8. 2.0000000 1.943D-16 1.388D-17 0. 0  0. 0.]',%eps,1e-4);
assert_checkalmostequal(tr,0:9,%eps,1e-4);

//test case 4 
[xr,tr]=impz([0.4 0.2],[4 5 6],3,10) 


// test case 5
B = [0.021895   0.109474   0.218948   0.218948   0.109474   0.021895];
A = [1.0000  -1.2210   1.7567  -1.3348   0.7556  -0.2560];
impz(B, A) 

 */