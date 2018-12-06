function [n, Wn, beta, ftype] = kaiserord (f, m, dev, fs)
//Return the parameters needed to produce a filter of the desired specification from a Kaiser window.
//Calling Sequence
//[n, Wn, beta, ftype] = kaiserord (f, m, dev, fs)
//[…] = kaiserord (f, m, dev, fs)
//[…] = kaiserord (f, m, dev)
//Parameters
//f: Pairs of frequency band edges.
//m: Magnitude response for each band.
//dev: Deviation of the filter.
//fs: Sampling rate.
//Description
//The vector f contains pairs of frequency band edges in the range [0,1]. The vector m specifies the magnitude response for each band. The values of m must be zero for all stop bands and must have the
//same magnitude for all pass bands. The deviation of the filter dev can be specified as a scalar or a vector of the same length as m. The optional sampling rate fs can be used to indicate that f is in
//Hz in the range [0,fs/2].
//
//The returned value n is the required order of the filter (the length of the filter minus 1). The vector Wn contains the band edges of the filter suitable for passing to fir1. The value beta is the
//parameter of the Kaiser window of length n+1 to shape the filter. The string ftype contains the type of filter to specify to fir1.
//
//The Kaiser window parameters n and beta are computed from the relation between ripple (A=-20*log10(dev)) and transition width (dw in radians) discovered empirically by Kaiser:
//
// 
//           / 0.1102(A-8.7)                        A > 50
//    beta = | 0.5842(A-21)^0.4 + 0.07886(A-21)     21 <= A <= 50
//           \ 0.0                                  A < 21
//
//    n = (A-8)/(2.285 dw)
//Examples
//[n, w, beta, ftype] = kaiserord ([1000, 1200], [1, 0], [0.05, 0.05], 11025)
//n =  70
//w =  0.199
//beta =  1.5099
//ftype = low

if (argn(2) < 3 | argn(2) > 4)
error("Wrong number of input arguments.")
end


  if argn(2)<4 then 
      fs=2; 
      end

  if length(f)~=(2*length(m)-2) then
    error("kaiserord must have one magnitude for each frequency band");
  end
  
  if or(m(1:length(m)-2)~=m(3:length(m))) then
    error("kaiserord pass and stop bands must be strictly alternating");
  end
  if length(dev)~=length(m) & length(dev)~=1 then
    error("kaiserord must have one deviation for each frequency band");
  end
  dev = min(dev);
  if dev <= 0 then
      error("kaiserord must have dev>0"); 
      end
  Wn = (f(1:2:length(f))+f(2:2:length(f)))/fs;

  if length(Wn) == 1 then
    if m(1)>m(2) then
        ftype='low'; 
        else 
        ftype='high';
         end
  elseif length(w) == 2 then
    if m(1)>m(2) then 
        ftype='stop'; 
        else 
        ftype='pass'; 
        end
  else
    if m(1)>m(2),
         ftype='DC-1'; 
        else 
        ftype='DC-0'; 
        end
  end

  A = -20*log10(dev);
  if (A > 50)
    beta = 0.1102*(A-8.7);
  elseif (A >= 21)
    beta = 0.5842*(A-21)^0.4 + 0.07886*(A-21);
  else
    beta = 0.0;
  end

  dw = 2*%pi*min(f(2:2:length(f))-f(1:2:length(f)))/fs;
  n = max(1,ceil((A-8)/(2.285*dw)));
  
  if ((m(1)>m(2)) == ((length(Wn)-fix(length(Wn)./2).*2)==0)) & (n-fix(n./2).*2)==1 then
      n = n+1; 
      end

endfunction
