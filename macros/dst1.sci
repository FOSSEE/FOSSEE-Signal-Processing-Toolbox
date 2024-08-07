function y = dst1(x, n)
//Computes the type I discrete sine transform of x
//Calling Sequence:
//y= dst1(x)
//y= dst1(x,n)
//Parameters: 
//x: real or complex valued vector
//n= Length to which x is trimmed before transform 
//Description:
//Computes the type 1 discrete sine transform of x. If n is given, then x is padded or trimmed to length n before computing the transform. 
//If x is a matrix, compute the transform along the columns of the the matrix.
//Example:
//dst1([1 3 6])
//ans = [7.94974, -5, 1.94974]

  funcprot(0);
  rhs = argn(2);
  if (rhs < 1 | rhs > 2)
    error("ds1: wrong number of input arguments");
  end

  transpose = (size(x, 'r') == 1);
  if (transpose)
    x = x (:);
  end

  [nr, nc] = size(x);
  if (rhs == 1)
    n = nr;
  elseif (n > nr)
    x = [ x ; zeros(n-nr, nc) ];
  elseif (n < nr)
    x (nr-n+1 : n, :) = [];
  end

  d = [ zeros(1, nc); x; zeros(1, nc); -flipdim(x, 1) ];
  y = fft(d, -1, find(size(d) ~= 1, 1))/2*%i;
  y = y(2:nr+1, :);
  if (isreal(x))
    y = real (y);
  end

  if (transpose)
    y = y.';
  end

endfunction

//input validation:
//assert_checkerror("dst1()", "ds1: wrong number of input arguments");
//assert_checkerror("dst1(1, 2, 3)", "Wrong number of input arguments.");

//tests:
//x = log(linspace(0.1,1,32));
//y = dst1(x);
//assert_checkalmostequal(y(3), sum(x.*sin(3*%pi*[1:32]/33)), 100*%eps);
//
//assert_checkalmostequal(dst1([-1; -3; -6]), [-7.9497; 5.0000; -1.9497], 5*10^-5);
//assert_checkalmostequal(dst1([-1 2 2], 5), [3.2321, 0.8660, -3.0000], 5*10^-5);
//assert_checkalmostequal(dst1([1+2*%i, 5+3*%i, 8+2*%i]), [11.3639+5.8284*%i, -7.0000-0*%i, 1.3640-0.1716*%i], 5*10^-4);
//assert_checkalmostequal(dst1([1+2*%i; 5+3*%i; 8+2*%i], 2), [7.7942+3.4641*%i; -6.0622-0*%i; 0], 5*10^-5);
//assert_checkalmostequal(dst1([-1-3*%i, 4*%i; -2-7*%i, 3]), [-2.5981-8.6603*%i, 2.5981+3.4641*%i; 0.8660+3.4641*%i, -2.5981+3.4641*%i], 5*10^-5);
