function w = chebwin(m, at)
// Generate a Chebyshev window.
//
// Syntax
//   w = chebwin(m)
//   w = chebwin(m, at)
//
// Parameters
// m: Positive integer. Length of the Chebyshev window.
// at: Real scalar. Attenuation in decibels. Default is 100 dB.
// w: Vector. The Chebyshev window.
//
// Description
// This function generates a Chebyshev window of length `m` with a specified attenuation `at`. If `at` is not provided, it defaults to 100 dB.
//
// Examples
// w = chebwin(5, 60)
// 

 funcprot(0);
    rhs= argn(2);

  if (rhs < 1 | rhs > 2)
    error("Wrong Number of input arguments");
  elseif (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("chebwin: M must be a positive integer");
  elseif (rhs == 1)
    at = 100;
  elseif (~ (isscalar (at) & isreal(at)))
    error ("chebwin: AT must be a real scalar");
  end

  if (m == 1)
    w = 1;
  else
    // beta calculation
    gamma = 10^(-at/20);
    beta = cosh(1/(m-1) * acosh(1/gamma));
    // freq. scale
    k = (0:m-1);
    x = beta*cos(%pi*k/m);
    // Chebyshev window (freq. domain)
    p = cheb(m-1, x);
    // inverse Fourier transform
    if (modulo(m,2))
      w = real(fft(p));
      M = (m+1)/2;
      w = w(1:M)/w(1);
      w = [w(M:-1:2) w]';
    else
      //half-sample delay (even order)
      p = p.*exp(%i*%pi/m * (0:m-1));
      w = real(fft(p));
      M = m/2+1;
      w = w/w(2);
      w = [w(M:-1:2) w(2:M)]';
    end
  end

endfunction
