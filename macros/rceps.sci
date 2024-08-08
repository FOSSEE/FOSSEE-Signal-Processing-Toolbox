 /*Description
        Real cepstrum and minimum-phase reconstruction
        If  called with two output arguments,
        the minimum phase reconstruction of the signal x is returned in ym.Calling Sequence
        [y,ym] = rceps(x)
    Parameters
        x : A vector or a Matirx
        y : Real cepstrum
        ym : Minimum-phase reconstruction
    Dependencies fft1 , ifft1
    Example:
        // create a 45 Hz sine wave sampled at 100 Hz. 
        t = 0:0.01:1.27;
        s1 = sin(2*%pi*45*t);
        s2 = s1 + 0.5*[zeros(1,20) s1(1:108)]; //Add an echo of the signal, with half the amplitude, 0.2 seconds after the beginning of the signal.
        c = rceps(s2); // real cepstrum of signal 
        plot(t,c)
*/
function [y, xm]= rceps(x)
    if(argn(2)~= 1 )
    error("Wrong number of Input Arguments");
    end
    if(argn(1)>2)
    error("Wrong number of Output Arguments")
    end
      f = abs(fft1(x));
      if (or(f == 0))
        error ("The spectrum of x contains zeros, unable to compute real cepstrum");
      end
      y = real(ifft1(log(f)));
      if argn(1) == 2 then
        n=max(size(x));
        if size(x,1)==1 then
          if (n-fix(n./2).*2) ==1 then
            xm = [y(1), 2*y(2:n/2+1), zeros(1,n/2)];
          else
            xm = [y(1), 2*y(2:n/2), y(n/2+1), zeros(1,n/2-1)];
          end
        else
          if (n-fix(n./2).*2)==1
            xm = [y(1,:); 2*y(2:n/2+1,:); zeros(n/2,size(y,2))];
          else
            xm = [y(1,:); 2*y(2:n/2,:); y(n/2+1,:); zeros(n/2-1,size(y,2))];
          end
        end
        xm = real(ifft1(exp(fft1(xm))));
      end
endfunction
