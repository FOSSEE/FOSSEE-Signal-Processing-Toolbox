/*Description
        Sort the numbers z into complex conjugate pairs ordered by increasing real part.
        The negative imaginary complex numbers are placed first within each pair. All real numbers (those with abs (imag (z) / z) < tol) are placed after the complex pairs.
        and the resulting tolerance for a given complex pair is 100 * eps (abs (z(i))).
        Signal an error if some complex numbers could not be paired. Signal an error if all complex numbers are not exact conjugates (to within tol).
        Note that there is no defined order for pairs with identical real parts but differing imaginary parts
Calling Sequence
         cplxpair (z)
         cplxpair (z, tol)
         cplxpair (z, tol, dim)
Parameters:
         z is a matrix or vector.
         tol is a weighting factor which determines the tolerance of matching. The default value is 100.
         By default the complex pairs are sorted along the first non-singleton dimension of z. If dim is specified, then the complex pairs are sorted along this dimension.
Dependencies: ipermute
Example:
        The following code
        [ cplxpair(exp(2*%i*%pi*[0:4]'/5)), exp(2*%i*%pi*[3; 2; 4; 1; 0]/5) ]
        Produces the following output
                ans =
             -0.80902 - 0.58779i  -0.80902 - 0.58779i
             -0.80902 + 0.58779i  -0.80902 + 0.58779i
              0.30902 - 0.95106i   0.30902 - 0.95106i
              0.30902 + 0.95106i   0.30902 + 0.95106i
              1.00000 + 0.00000i   1.00000 + 0.00000i
*/
function zsort = cplxpair (z, tol, dim)
  if (nargin < 1)
    error("Invalid inputs");
  end
  // default  double
  realmin = 2.2251e-308
  if (isempty (z))
    zsort = zeros (size (z,1) , size (z,2));
    return;
  end
  if (nargin < 2 || isempty (tol))
    tol = 100* %eps;
  elseif (~ isscalar (tol) || tol < 0 || tol >= 1)
    error ("cplxpair: TOL must be a scalar number in the range 0 <= TOL < 1");
  end
  nd = ndims (z);
  if (nargin < 3)
    // Find the first singleton dimension.
    sz = size (z);
    dim = find (sz > 1, 1);
    if isempty(dim) 
        dim  = 1;
    end
  else
    dim = floor (dim);
    if (dim < 1 || dim > nd)
      error ("cplxpair: invalid dimension DIM");
    end
  end
  // Move dimension to analyze to first position, and convert to a 2-D matrix.
  perm = [dim:nd, 1:dim-1];
  z = permute (z, perm);
  sz = size (z);
  n = sz(1);
  m = prod (sz) / n;
  z = matrix (z, n, m);
  // Sort the sequence in terms of increasing real values.
  [temp, idx] = gsort (real (z), 1 , "i");
  z = z(idx + n * ones (n, 1) * [0:m-1]);
  // Put the purely real values at the end of the returned list.
  [idxi, idxj] = find (abs (imag (z)) ./ (abs (z) + realmin) <= tol);
  // Force values detected to be real within tolerance to actually be real.
  z(idxi + n*(idxj-1)) = real (z(idxi + n*(idxj-1)));
  //if idxi and idxj are not scalers
  if ~isscalar(idxi) then
      v = ones(size(idxi,1),size(idxi,2));
  else
      v = 1 ;
  end
  q = sparse ([idxi' idxj'], v, [n m]);
  nr = sum (q, 1);
  [temp, idx] = gsort (q, 'r','i');
  midx = idx + size (idx,1) * ones (size (idx,1), 1) * [0:size(idx,2)-1];
  z = z(midx);
  zsort = z;
  // For each remaining z, place the value and its conjugate at the start of
  // the returned list, and remove them from further consideration.
  for j = 1:m
    p = n - nr(j);
    for i = 1:2:p
      if (i+1 > p)
        error ("cplxpair: could not pair all complex numbers");
      end
      [v, idx] = min (abs (z(i+1:p,j) - conj (z(i,j))));
      if (v >= tol * abs (z(i,j)))
        error ("cplxpair: could not pair all complex numbers");
      end
      // For pairs, select the one with positive imaginary part and use it and
      // it's conjugate, but list the negative imaginary pair first.
      if (imag (z(i,j)) > 0)
        zsort([i, i+1],j) = [conj(z(i,j)), z(i,j)];
      else
        zsort([i, i+1],j) = [conj(z(idx+i,j)), z(idx+i,j)];
      end
      z(idx+i,j) = z(i+1,j);
    end
  end
  // Reshape the output matrix.
  zsort = ipermute (matrix (zsort, sz), perm);
endfunction

