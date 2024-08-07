function m = ifht(d, n, dim)
//Calculate the inverse Fast Hartley Transform of real input D.
//Calling Sequence:
//m: ifht(d)
//m: ifht(d,n)
//m: ifht(d,n,dim)
//Parameters: 
//d: Real or complex scalar or vector.
//n: Integer. Specifies the number of elements of x to be used.
//dim: Integer. Specifies the dimention of the matrix along which the ifht is performed.
//Description:
//Calculate the inverse Fast Hartley Transform of real input d. If d is a matrix, the inverse Hartley transform is calculated along the columns by default.
//The options n and dim are similar to the options of FFT function. 'n' is an integer that determines the number of elements of 'd' to use. If 'n' is larger than the dimension along which the ifht is calculated, then 'd' is resized and padded with zeros to match the required size. If n < d, then 'd' is truncated to match the required size.
//'dim' is an integer that specifies the dimension of the matrix along which the ifht is to be performed. By default, the ifht is computed along the first non-singleton dimension of the array.
//The forward and inverse Hartley transforms are the same (except for a scale factor of 1/N for the inverse hartley transform), but implemented using different functions.
//The definition of the forward hartley transform for vector d, m[K] = 1/N \sum_{i=0}^{N-1} d[i]*(cos[K*2*pi*i/N] + sin[K*2*pi*i/N]),
//for 0 <= K < N. m[K] = 1/N \sum_{i=0}^{N-1} d[i]*CAS[K*i], for 0 <= K < N.
//Examples:
//ifht(1 : 4)
//ans = [2.5, -1, -0.5, 0]
  
  funcprot(0);
  rhs = argn(2);
  if (rhs < 1 | rhs > 3)
    error("Wrong number of input arguments.");
  end
  dimension = size(d);
  nd = find(dimension ~= 1, 1);
  if (rhs == 3)
    if isempty(n)
      y = fft(d, 1, dim);
    else
      dimension(dim)=n;
      y=fft(resize_matrix(d, dimension), 1, dim);
    end
  elseif (rhs == 2)
    if isempty(n)
      y = fft(d, 1, nd);
    else
      dimension(nd) = n;
      y=fft(resize_matrix(d, dimension), 1, nd)
    end
  else
     y = fft(d, 1, nd);
  end

  m = real(y) + imag(y);

endfunction

//input validation:
//assert_checkerror("ifht()", "Wrong number of input arguments.");
//assert_checkerror("ifht(1, 2, 3, 4)", "Wrong number of input arguments.");

////tests:
//assert_checkequal(ifht(1+2*%i), 3);
//assert_checkequal(ifht((1:4)), [2.5, -1, -0.5, 0]);
//assert_checkequal(ifht([1:4]', 2), [1.5; -0.5]);
//assert_checkequal(ifht([1:4]', 2, 2), [0.5 0.5; 1 1; 1.5 1.5; 2 2]);
//assert_checkequal(ifht([-1 2; 3 -5]), [1 -1.5; -2 3.5]);
//assert_checkalmostequal(ifht([1:3; -2:-5]), [2, -0.7887, -0.2113], 5*10^-4);
//assert_checkequal(ifht([1:3; -2:-5], 1, 1), [1:3]);
//assert_checkequal(ifht([1+2*%i, 3*%i; -4-3*%i, -5*%i]), [-2 -1; 5 4]);
//assert_checkequal(ifht([1+2*%i, 3*%i; -4-3*%i, -5*%i], 1, 2), [3; -7]);
