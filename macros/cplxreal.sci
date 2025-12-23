function [zc, zr] = cplxreal(z, tol, dim)
// Separate numbers into complex-conjugate pairs and real values.
//
// Syntax
//   [zc, zr] = cplxreal(z)
//   [zc, zr] = cplxreal(z, tol)
//   [zc, zr] = cplxreal(z, tol, dim)
//
// Parameters
// z: Vector or matrix. Input numbers to be separated.
// tol: Scalar. Tolerance for matching complex conjugates. Default is 100 * eps.
// dim: Integer. Dimension along which to sort. Default is the first non-singleton dimension.
// zc: Vector or matrix. Complex conjugate pairs.
// zr: Vector or matrix. Real numbers.
//
// Description
// Sort the numbers z into complex-conjugate-valued and real-valued elements.
// The positive imaginary complex numbers of each complex conjugate pair are returned in zc and the real numbers are returned in zr.
// Signal an error if some complex numbers could not be paired.
// Signal an error if all complex numbers are not exact conjugates (to within tol).
// Note that there is no defined order for pairs with identical real parts but differing imaginary parts//
// Examples
// z = roots([1, 0, 0, 1, 0])
// [zc, zr] = cplxreal(z)


  if (nargin < 1 || nargin > 3)
    error("invalid inputs");
  end
  if (isempty (z))
    zc = zeros (size (z,1),size(z,2));
    zr = zeros (size (z,1),size(z,2));
    return;
  end
  if (nargin < 2 || isempty (tol))
    tol = 100 * %eps ;
  end
  if (nargin >= 3)
    zcp = cplxpair(z,tol,dim);
  else
    zcp = cplxpair (z , tol);
  end
  nz = max(size (z) );
  idx = nz;
  while ((idx > 0) && (zcp(idx) == 0 || (abs (imag (zcp(idx))) ./ abs (zcp(idx))) <= tol))
    zcp(idx) = real (zcp(idx));
    idx = idx - 1;
  end
  if (pmodulo (idx, 2) ~= 0)
    error ("cplxreal: odd number of complex values was returned from cplxpair");
  end
  zc = zcp(2:2:idx);
  zr = zcp(idx+1:nz);
endfunction
