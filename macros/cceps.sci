function y = cceps(x, correct)
//Return the complex cepstrum of the vector x.
//Calling Sequence:
//cceps (x)
//cceps(x, correct)
//Parameters:
//x: vector
//correct: If 1, a correction method is applied.
//Description:
//This function return the complex cepstrum of the vector x.
//If the optional argument correct has the value 1, a correction method is applied. The default is not to do this.
//Examples:
//cceps([1,2,3], 1)
//ans = 1.9256506
//      0.9634573
//     -1.0973484

  if(argn(2) < 1 | argn(2) > 2)
    error("Wrong number of input arguments.");
  end

  if (argn(2) == 1)
    correct = 0;
  end

  [r, c] = size(x);
  if (c ~= 1)
    if (r == 1)
      x = x';
      r = c;
    else
      error ("x must be a vector");
    end
  end

  F = fft(x);  
  if (min(abs(F)) == 0)
    error('bad signal x, some Fourier coefficients are zero.');
  end 

  h = fix (r / 2);
  cor = 0;
  if (2*h == r)
    cor = (correct & (real(F(h + 1)) < 0));
    if (cor)
      F = fft(x(1:r-1));
      if (min(abs(F)) == 0)
        error('bad signal x, some Fourier coefficients are zero.');
      end
    end
  end
  y = fftshift(ifft((log (F))));

  if (correct)
    y = real(y);
    if (cor)
      y (r) = 0;
    end
  end

endfunction

//input validation:
//assert_checkerror("cceps()", "Wrong number of input arguments.");
//assert_checkerror("cceps(1, 2, 3)", "Wrong number of input arguments.");
//assert_checkerror("cceps([1, 2; 3, 4])", "x must be a vector");
//assert_checkerror("cceps(0)", 'bad signal x, some Fourier coefficients are zero.');
//assert_checkerror("cceps(zeros(10, 1))", 'bad signal x, some Fourier coefficients are zero.');

//tests:
//assert_checkalmostequal(cceps([1, 2, 3]), [1.9257; 0.9635; -1.0973], 0.5*10^-4);
//assert_checkequal(cceps([1, 2, 3]), cceps([1, 2, 3], 1));
//assert_checkequal(cceps([-1, -2, -3]), cceps([-1; -2; -3]));
//assert_checkalmostequal(cceps([1+2*%i; -2-2*%i; -3+2*%i]), [0.4734+1.1174*%i; 1.2144+1.5358*%i; -0.1899+0.0247*%i], 5*10^-3);
//assert_checkalmostequal(cceps([1+2*%i; -2-2*%i; -3+2*%i], 1), [0.4734; 1.2144; -0.1899], 5*10^-4);
