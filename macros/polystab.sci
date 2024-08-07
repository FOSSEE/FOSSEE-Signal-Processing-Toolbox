function y = polystab(x)
//Stabilize the polynomial transfer function. 
//Calling Sequence:
//y = polystab(x)
//Parameters: 
//x: real or complex valued vector
//Description:
//This function stabilizes the polynomial transfer function by replacing all 
//roots outside the unit circle with their reflection inside the unit circle.
//Example:
//polystab([1,3,5])
//ans=
//[1, 0.6, 0.2] 
 
  funcprot(0);
  if (argn(2) ~= 1)
    error("polystab: wrong number of input arguments");
  end
  root = roots(x);
  vals = find(abs(root) > 1);
  root(vals) = 1 ./ conj(root(vals));
  b = x(1) * poly(root, 'x');
  y = flipdim(coeff(b), 2);
  if (isreal(x))
    y = real(y);
  end

endfunction

//input validation:
//assert_checkerror("polystab()", "polystab: wrong number of input arguments");
//assert_checkerror("polystab(1, 2)", "Wrong number of input arguments.")

//tests:
//assert_checkalmostequal(polystab([1, 3, 5]), [1, 0.6, 0.2], %eps);
//assert_checkequal(polystab([1; 3; 5]), polystab([1, 3, 5]));
//assert_checkalmostequal(polystab([1+3*%i, 4+2*%i, 2+2*%i]), [1 + 3*%i, 1.35664 + 1.84888*%i, 0.88566 + 0.88566*%i], 5*10^-5);
//assert_checkalmostequal(polystab([-1; 3+%i; -2-6*%i]), [-1, 0.3 + 0.4*%i, -0.05-0.15*%i], 5*10^-5);
