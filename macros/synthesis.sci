function x = synthesis (y, c)
//Compute a signal from its short-time Fourier transform.
//Calling Sequence:
//synthesis(y, c)
//Parameters:
//y: Real or complex matrix representing a signal's short-time fourier transform.
//c: 3-element vector C specifying window size, increment and window type.
//Description:
//Compute a signal from its short-time Fourier transform 'y' and a 3-element vector 'c' specifying window size, increment, and window type.
//A window type of 1 represents a hanning window, 2 represents a hamming window and 3 represents a rectangular window.
//The values 'y' and 'c' can be derived by [y, c] = stft (x, ...)

  funcprot(0);
  rhs = argn(2);
  if (rhs ~= 2)
    error("synthesis: wrong number of input arguments");
  end

  if (length(c) ~= 3)
    error ("synthesis: C must contain exactly 3 elements");
  end

  w_size = c(1);
  inc    = c(2);
  w_type = c(3);

  if (w_type == 1)
    w_coeff = window('hn', w_size);
  elseif (w_type == 2)
    w_coeff = window('hm', w_size);
  elseif (w_type == 3)
    w_coeff = ones (w_size, 1);
  else
    error ("synthesis: window_type must be 1, 2, or 3");
  end

  if (isnan(w_coeff))
    w_coeff = 1;
  end
  z = real(fft(y, 1, find(size(y) ~= 1, 1)));
  st = fix((w_size-inc) / 2);
  z = z(st+1:st+inc, :);
  w_coeff = w_coeff(st+1:st+inc);

  nc = size(z, 'c');
  for i = 1:nc
    z(:, i) = z(:, i) ./ w_coeff;
  end

  x = matrix(z, inc * nc, 1);

endfunction

//input validation:
//assert_checkerror("synthesis(1)", "synthesis: wrong number of input arguments");
//assert_checkerror("synthesis(1, [1 2])", "synthesis: C must contain exactly 3 elements");
//assert_checkerror("synthesis(1, [1 2 3 4])", "synthesis: C must contain exactly 3 elements");
//assert_checkerror("synthesis(1, [1 2 4])", "synthesis: window_type must be 1, 2, or 3");

//tests:
//assert_checkequal(synthesis(1, [1 1 1]), 1);
//assert_checkequal(synthesis(4, [2 1 3]), 4);
//assert_checkalmostequal(synthesis(-6, [2 1 2]), -75, %eps);
//assert_checkalmostequal(synthesis(-9, [2; 1; 2]), -112.50, 10*%eps);
//assert_checkequal(synthesis(5*%i, [2; 1; 3]), 0);
//assert_checkequal(synthesis([1 2; -3, -6], [1; 1; 2]), [-1; -2]);
//assert_checkalmostequal(synthesis([1 1+2*%i; -3-4*%i, -5], [2; 1; 2]), [-12.5; -25], %eps);
