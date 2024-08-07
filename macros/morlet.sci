function [psi,x] = morlet(lb, ub, n)
//Compute the Morlet wavelet.
//Calling sequence:
//[psi,x]= morlet(lb,ub,n)
//Parameters:
//lb: Real or complex valued vector/scalar
//ub: Real or complex valued vector/scalar
//n: Real positive scalar number
//Description:
//This function returns values of the Morlet wavelet in the specified interval for all the sample points.
//Example:
//[a,b] = morlet([1 2 3], [1 2 3], 1)
//a = [0.1720498; -0.1135560; -0.0084394]
//b = [1; 2; 3]

  funcprot(0);
  rhs = argn(2);

  if (rhs ~= 3) then
      error("morlet: wrong number of input arguments");
  end

  if (length(lb) ~= length(ub)) then
      error("morlet: arg1 and arg2 msut have same dimension");
  end

  if (~isreal(n) | n <= 0) then
    error("morlet: n must be a strictly positive real number");
  end
  x = [];
  for i=1:length(lb)
      x(i, :) = linspace(lb(i), ub(i), n);
  end
  psi = cos(5.*x) .* exp(-x.^2/2);

endfunction

//input validation:
//assert_checkerror("morlet()", "morlet: wrong number of input arguments");
//assert_checkerror("morlet(1, 2)", "morlet: wrong number of input arguments");
//assert_checkerror("morlet(1, 2, 3, 4)", "Wrong number of input arguments.");
//assert_checkerror("morlet(1, 2, -1)", "morlet: n must be a strictly positive real number");
//assert_checkerror("morlet(1, 2, 2+3*%i)", "morlet: n must be a strictly positive real number");
//assert_checkerror(" morlet([5, 2, 7], [1, 3], 3)", "morlet: arg1 and arg2 msut have same dimension");

//test basic input:
//[a, b] = morlet(1, 2, 3);
//assert_checkalmostequal(a, [0.17205, 0.11254, -0.11356], 5e-5);
//assert_checkalmostequal(b, [1, 1.5, 2], %eps);

//test complex input:
//[a, b] = morlet(3+2*%i, 4+8*%i, 2);
//assert_checkalmostequal(a, [-495.15886-756.35443*%i, -5.08135E26-3.07588E27*%i], 5e-5);
//assert_checkalmostequal(b, [3+2*%i, 4+8*%i], %eps);

//test real vector:
//[a, b] = morlet([1, 2], [3, 4], 2);
//A = [0.1720498, -0.0084394; -0.113556, 0.0001369];
//B = [1, 3; 2, 4];
//assert_checkalmostequal(A, a, 5e-5);
//assert_checkalmostequal(B, b, %eps);

//test complex vector:
//[a, b] = morlet([1 + 2*%i, 3*%i], [2*%i, 2 + 3*%i], 1);
//A = [81377.39587; -19069291.16508 + 5732843.75676*%i];
//B = [2*%i; 2+3*%i];
//assert_checkalmostequal(a, A, 5e-5);
//assert_checkalmostequal(b, B, %eps);
