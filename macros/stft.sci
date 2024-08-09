function [y, c] = stft(x, win_size, inc, num_coef, win_type)
//Compute the short-time Fourier transform of the vector X.
//Calling Sequence:
//y = stft(x)
//y = stft(x, win_size)
//y = stft(x, win_size, inc)
//y = stft(x, win_size, inc, num_coef)
//y = stft(x, win_size, inc, num_coef, win_type)
//[y, c] = stft(x)
//[y, c] = stft(x, win_size)
//[y, c] = stft(x, win_size, inc)
//[y, c] = stft(x, win_size, inc, num_coef)
//[y, c] = stft(x, win_size, inc, num_coef, win_type)
//Parameters:
//x: Real scalar or vector
//win_size: Size of the window used
//inc: Increment
//num_coef: Coefficients of Fourier transform
//win_type: Type of window
//Description:
//Compute the short-time Fourier transform of the vector X with num_coef coefficients by applying a window of win_size data points and an increment of inc points.
//Before computing the Fourier transform, one of the following windows is applied:
//"hanning" -> win_type = 1
//"hamming" -> win_type = 2
//"rectangle" -> win_type = 3
//The window names can be passed as strings or by the win_type number.
//The following defaults are used for unspecified arguments: win_sizse = 80, inc = 24, num_coef = 64, and win_type = 1.
//y = stft(x, ...)' returns the absolute values of the Fourier coefficients according to the NUM_COEF positive frequencies.
//'[y, c] = stft (x, ...)' returns the entire stft-matrix y and a 3-element vector c containing the window size, increment, and window type,
//which is needed by the 'synthesis' function.
//Examples:
//[y, c] = stft([1; -2; -5])
//y = []
//c = [80, 24, 1]
 
  funcprot(0);
  rhs = argn(2);
  if (rhs < 1 | rhs > 5)
    error("Wrong number of input arguments.");
  end
  if (~isvector (x))
    error ("stft: X must be a vector");
  end
  
  if (rhs == 1)
    win_size = 80;
    inc = 24;
    num_coef = 64;
    win_type = 1;
  elseif (rhs == 2)
    inc = 24;
    num_coef = 64;
    win_type = 1;
  elseif (rhs == 3)
    num_coef = 64;
    win_type = 1;
  elseif (rhs == 4)
      win_type = 1;
  end
  
  if (type(win_type) == 10)
    switch (convstr(win_type, 'l'))
      case "hanning"   , win_type = 1;
      case "hamming"   , win_type = 2;
      case "rectangle" , win_type = 3;
      otherwise
        error ("stft: unknown window type");
    end
  end

  x = x(:);

  ncoef = 2 * num_coef;
  if (win_size > ncoef)
    win_size = ncoef;
    printf ("stft: window size adjusted to %f\n", win_size);
  end
  num_win = fix ((size(x, 'r') - win_size) / inc);

  switch (win_type)
    case 1 , win_coef = (window('hn', win_size))';
    case 2 , win_coef = (window('hm', win_size))';
    case 3 , win_coef = ones (win_size, 1);
  end
  
  z = zeros (ncoef, num_win + 1);
  start = 1;
  for i = 0:num_win
    z(1:win_size, i+1) = x(start:start+win_size-1) .* win_coef;
    start = start + inc;
  end

  y = fft(z, -1, find(size(z) ~= 1, 1));

  if (nargout() == 1)
    y = abs(y(1:num_coef, :));
  else
    c = [win_size, inc, win_type];
  end

endfunction

//input validation:
//assert_checkerror("stft()", "Wrong number of input arguments.");
//assert_checkerror("stft(1, 2, 3, 4, 5, 6)", "Wrong number of input arguments.");
//assert_checkerror("stft([1 2; 3 4])", "stft: X must be a vector");
//s = "square";
//assert_checkerror("stft([1 2 3], 8, 4, 6, s)", "stft: unknown window type");

//tests:
//assert_checkequal(stft([1 2 3]), stft([1 21 3], 80, 24, 64, 1));
//assert_checkequal(stft([1 2 3], 80), stft([1 21 3], 80, 24, 64, 1));
//assert_checkequal(stft([1 2 3], 80, 24), stft([1 21 3], 80, 24, 64, 1));
//assert_checkequal(stft([1 2 3], 80, 24, 64), stft([1 21 3], 80, 24, 64, 1));

//[y, c] = stft([1; -2; -5]);
//assert_checkequal(y, []);
//assert_checkequal(c, [80, 24, 1]);

//y = stft([1 21 3], 3, 2, 2);
//assert_checkequal(y, [21; 21]);

//[y, c] = stft([1 21 3], 3, 2, 2);
//assert_checkequal(y, [21; -21*%i; -21; 21*%i]);
//assert_checkequal(c, [3 2 1]);

//y = stft([1, 3-2*%i, -6-7*%i], 3, 2, 3);
//assert_checkalmostequal(y, [3.60555; 3.60555; 3.60555], 0.5*10^-5);

//[y c] = stft([1; 3-2*%i; -6-7*%i], 3, 2, 3);
//assert_checkalmostequal(y, [3-2*%i; -0.2321-3.5981*%i; -3.2321-1.5981*%i; -3+2*%i; 0.2321+3.5981*%i; 3.2321+1.5981*%i], 5*10^-4);
//assert_checkequal(c, [3 2 1]);

//[y c] = stft([1; 3-2*%i; -1-2*%i], 3, 2, 3, 3);
//assert_checkalmostequal(y, [3-4*%i; -0.4641-1.7321*%i; 0-1.4641*%i; -3; 5.4641*%i; 6.4641+1.7321*%i], 5*10^-4);
//assert_checkequal(c, [3 2 3]);

//y = stft([3*%i; 4*%i; -5*%i], 3, 2, 3, 1);
//assert_checkequal(y, [4; 4; 4]);
