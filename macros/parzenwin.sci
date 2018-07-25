function w = parzenwin (m)
//This function returns the filter coefficients of a Parzen window.
//Calling Sequence
//w = parzenwin (m)
//Parameters
//m: positive integer value
//w: output variable, vector of real numbers
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Parzen window of length m supplied as input, to the output vector y.
//Examples
//parzenwin(3)
//ans  =
//    0.0740741
//    1.
//    0.0740741

 funcprot(0);
    rhs= argn(2);

  if (rhs ~= 1)
    error("Wrong Number of input arguments");
  elseif (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("parzenwin: M must be a positive integer");
  end

  N = m - 1;
  n = -(N/2):N/2;
  n1 = n(find(abs(n) <= N/4));
  n2 = n(find(n > N/4));
  n3 = n(find(n < (-N/4)));

  w1 = 1 -6.*(abs(n1)./(m/2)).^2 + 6*(abs(n1)./(m/2)).^3;
  w2 = 2.*(1-abs(n2)./(m/2)).^3;
  w3 = 2.*(1-abs(n3)./(m/2)).^3;
  w = [w3 w1 w2]';

endfunction
