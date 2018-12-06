function y = cceps (x,correct)
//Return the complex cepstrum of the vector x
//Calling Sequence
//cceps (x)
//cceps(x, correct)
//Parameters
//x: vector.
//correct: if 1, a correction method is applied.
//Description
//This function return the complex cepstrum of the vector x. If the optional argument correct has the value 1, a correction method is applied. The default is not to do this.
//Examples
//cceps([1,2,3],1)
//ans = 1.9256506  
 //   0.9634573  
//  - 1.0973484 

if(argn(2)<1 | argn(2)>2)
error("Wrong number of input arguments.")
end
 if argn(2)==1 then
 correct=0;
end

 [r, c]=size(x)         
     if (c ~= 1)
    if (r == 1)
      x = x;
      r = c;
    else
      error ("x must be a vector");
    end
  end
  
        F = fft1(x);  
      if (min (abs (F)) == 0)
    error ('bad signal x, some Fourier coefficients are zero.');
  end 
 h = fix (r / 2);
  cor = 0;
  if (2 * h == r)
    cor = (c & (real (F (h + 1)) < 0));
    if (cor)
      F = fft1 (x(1:r-1))
      if (min (abs (F)) == 0)
        error ('bad signal x, some Fourier coefficients are zero.');
      end
    end
  end
  y = fftshift1 (ifft1 ((log (F))'));

  //## make result real
  if (c)
    y = real (y);
    if (cor)
     // ## make cepstrum of same length as input vector
      y (r) = 0;
    end
  end
    

endfunction


