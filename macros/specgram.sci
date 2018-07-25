// Copyright (C) 2018 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author:[insert name]
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in



function [S_r, f_r, t_r] = specgram(x, n , Fs , win , overlap)
//Generate a spectrogram for the signal x. The signal is chopped into overlapping segments of length n, and each segment is windowed and transformed into the frequency domain using the FFT. The default segment size is 256. If fs is given, it specifies the sampling rate of the input signal. The argument window specifies an alternate window to apply rather than the default of hanning (n). The argument overlap specifies the number of samples overlap between successive segments of the input signal. The default overlap is length (window)/2.

//CALLING SEQUENCE:
//[S, f, t] = specgram (x,n,fs,window,overlap)
//where
//S is the complex output of the FFT, one row per slice
//f is the frequency indices corresponding to the rows of S
// t is the time indices corresponding to the columns of S.



//Test cases:
//////1.
//N=1024;
//n=0:N-1;
//w=2*%pi/5;
//x=sin(w*n)+10*sin(2*w*n);
//[s,f,t]=specgram(x);
//grayplot(f,t,s)
//xlabel("frequency")
//ylabel("time")
////
[nargout,nargin]=argn();
  if nargin < 1 | nargin > 5
    error("wrong no. of input arguments");
  // make sure x is a vector
  elseif size(x,"c") ~= 1 & size(x,"r") ~= 1
    error ("specgram data must be a vector");
  end

  if nargin==1 then
      n=min(256,length(x));
      Fs=2;
      win = window("hn",n);
      overlap=ceil(length(win)/2);
      end




  if size(x,"c") ~= 1
       x = x';
        end

  // if only the win length is given, generate hanning win
  if isscalar(win)
       win = window("hn",win);

        end

  // should be extended to accept a vector of frequencies at which to
  // evaluate the Fourier transform (via filterbank or chirp
  // z-transform)
  if ~isscalar(n)
    error("specgram doesnot handle frequency vectors yet");
  end

  if (length (x) <= length (win))
    error ("specgram: segment length must be less than the size of X");
  end

  // compute win offsets
  win_size = length(win);
  if (win_size > n)
    n = win_size;
    warning ("specgram fft size adjusted to %d", n);
  end
  step = win_size - overlap;

  // build matrix of wined data slices
  offset = [ 1 : step : length(x)-win_size ];
  S = zeros (n, length(offset));
  for i=1:length(offset)
    S(:, i) =( x(offset(i):offset(i)+win_size-1).* win');
  end

  // compute Fourier transform
  S = fft (S);

  // extract the positive frequency components
  if (n-fix(n/2)*2)==1
    ret_n = (n+1)/2;
  else
    ret_n = n/2;
  end
  S = S(1:ret_n, :);

  f = [0:ret_n-1]*Fs/n;
  t = offset/Fs;
//  if nargout==0
//    //Matplot(20*log10(abs(S)));
//    //set (gca (), "ydir", "normal");
//    xlabel ("Time")
//    ylabel ("Frequency")
//  end
  if nargout>0
       S_r = S;
       end
  if nargout>1
       f_r = f;
        end
  if nargout>2
       t_r = t;
        end

endfunction
