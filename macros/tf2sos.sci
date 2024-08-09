function [sos,g] = tf2sos (B, A)
//This function converts direct-form filter coefficients to series second-order sections.
//Calling Sequence:
//[sos] = tf2sos (b, a)
//[sos, g] = tf2sos (b, a)
//Parameters:
//b: matrix of real numbers
//a: matrix of real numbers 
//Description:
//This function converts direct-form filter coefficients to series second-order sections.
//The input parameters b and a are vectors specifying the digital filter H(z) = B(z)/A(z). 
//The output is the sos matrix and the overall gain.
//If there is only one output argument, the overall filter gain is applied to the first second-order section in the sos matrix.
//Examples:
//tf2sos([1,2,3,4,5,6],2)
//ans =
//   0.50000   0.80579   1.07239   0.00000   0.00000   1.00000
//   1.00000  -1.10337   1.87524   0.00000   0.00000   1.00000
//   1.00000   1.49180  -0.00000   0.00000   1.00000   0.00000

  funcprot(0);
  if (nargin() ~= 2) then
    error("Wrong number of input arguments.");
  end
  S = syslin([], inv_coeff(flipdim(B(:)', 2)), inv_coeff(flipdim(A(:)', 2)));
  [z,p,k] = tf2zp(S);
  if (nargout() < 2)
    sos = clean(zp2sos(z,p,k));
  else
    [sos,g] = clean(zp2sos(z,p,k));
  end

endfunction

//tests:
//assert_checkerror("tf2sos(1)", "Wrong number of input arguments.");
//assert_checkerror("tf2sos(1, 2, 3)", "Wrong number of input arguments.");

//A = [-7 -12];
//B = [-1 -7];
//assert_checkequal(tf2sos(A, B), [7 12 0 1 7 0]);

//A = [1 2; 3 4];
//B = [3 2; 1 4];
//assert_checkalmostequal(tf2sos(A, B), [0.3333 0.0679 0.4768 1 -0.6667 1.3333; 1 2.7963 0 1 1 0], 5*10^-4);

//A = [1 1 1 1];
//B = [-1 -1; -1 -1];
//assert_checkalmostequal(tf2sos(A, B), [-1 0 -1 1 0 1; 1 1 0 1 1 0], 100*%eps);

//b = [1, 1];  
//a = [1, 2];  
//expected_sos = [1, 1, 0, 1, 2, 0];
//sos = tf2sos(b, a);
//assert_checkalmostequal(sos, expected_sos, %eps);

//b = [1, 2, 2];
//a = [1, -1, 1];  
//expected_sos = [1, 2, 2, 1, -1, 1];
//sos = tf2sos(b, a);
//assert_checkalmostequal(sos, expected_sos, 100*%eps);

//b = [1, 1, 1, 1];  
//a = [1, 1, 1, 1];  
//expected_sos = [
//    1, 0, 1, 1, 0, 1;
//    1, 1, 0, 1, 1, 0
//];
//sos = tf2sos(b, a);
//assert_checkalmostequal(sos, expected_sos, 100*%eps);
