function B = ipermute(A, perm)
    funcprot(0);
    // ipermute : Inverse permute the dimensions of a matrix A.
    // B = ipermute(A, perm) returns the array A with dimensions inverted
    // according to the permutation vector `perm`.
    // Validate the permutation vector
    if max(size(perm)) ~= ndims(A) || or(gsort(perm, "g", "i") ~= 1:ndims(A))
        error('Permutation vector must contain unique integers from 1 to ndims(A).');
    end
    // Compute the inverse permutation vector
    invPerm = zeros(size(perm,1),size(perm , 2));
    for i = 1:max(size(perm))
        invPerm(perm(i)) = i;
    end
    // Use the permute function with the inverse permutation
    B = permute(A, invPerm);
endfunction

function zsort = cplxpair (z, tol, dim)
  funcprot(0);
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

function [zc, zr] = cplxreal (z, tol, dim)
  funcprot(0);
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

function [SOS, G] = zp2sos(z, p, k, DoNotCombineReal)
//This function converts filter poles and zeros to second-order sections.
//Calling Sequence
//[sos] = zp2sos(z)
//[sos] = zp2sos(z, p)
//[sos] = zp2sos(z, p, k)
//[sos, g] = zp2sos(...)
//Parameters 
//z: column vector
//p: column vector
//k: real or complex value, default value is 1
//Description
//This function converts filter poles and zeros to second-order sections.
//The first and second parameters are column vectors containing zeros and poles. The third parameter is the overall filter gain, the default value of which is 1.
//The output is the sos matrix and the overall gain.
//If there is only one output argument, the overall filter gain is applied to the first second-order section in the sos matrix.
//Examples
//zp2sos([1, 2, 3], 2, 6)
//ans =
//    6  -18   12    1   -2    0
//    1   -3    0    1    0    0
  
  if argn(2) < 3 then
    k = 1;
  end
  if argn(2) < 2 then
    p = [];
  end

  DoNotCombineReal = 0;

  [zc, zr] = cplxreal(z(:));
  [pc, pr] = cplxreal(p(:));

  nzc = length(zc);
  npc = length(pc);

  nzr = length(zr);
  npr = length(pr);

  if DoNotCombineReal then

    // Handling complex conjugate poles
    for count = 1:npc
      SOS(count, 4:6) = [1, -2 * real(pc(count)), abs(pc(count))^2];
    end

    // Handling real poles
    for count = 1:npr
      SOS(count + npc, 4:6) = [0, 1, -pr(count)];
    end

    // Handling complex conjugate zeros
    for count = 1:nzc
      SOS(count, 1:3) = [1, -2 * real(zc(count)), abs(zc(count))^2];
    end

    // Handling real zeros
    for count = 1:nzr
      SOS(count + nzc, 1:3) = [0, 1, -zr(count)];
    end

    // Completing SOS if needed (sections without pole or zero)
    if npc + npr > nzc + nzr then
      for count = nzc + nzr + 1 : npc + npr // sections without zero
        SOS(count, 1:3) = [0, 0, 1];
      end
    else
      for count = npc + npr + 1 : nzc + nzr // sections without pole
        SOS(count, 4:6) = [0, 0, 1];
      end
    end

  else

    // Handling complex conjugate poles
    for count = 1:npc
      SOS(count, 4:6) = [1, -2 * real(pc(count)), abs(pc(count))^2];
    end

    // Handling pair of real poles
    for count = 1:floor(npr / 2)
      SOS(count + npc, 4:6) = [1, -pr(2 * count - 1) - pr(2 * count), pr(2 * count - 1) * pr(2 * count)];
    end

    // Handling last real pole (if any)
    if pmodulo(npr, 2) == 1 then
      SOS(npc + floor(npr / 2) + 1, 4:6) = [0, 1, -pr($)];
    end

    // Handling complex conjugate zeros
    for count = 1:nzc
      SOS(count, 1:3) = [1, -2 * real(zc(count)), abs(zc(count))^2];
    end

    // Handling pair of real zeros
    for count = 1:floor(nzr / 2)
      SOS(count + nzc, 1:3) = [1, -zr(2 * count - 1) - zr(2 * count), zr(2 * count - 1) * zr(2 * count)];
    end

    // Handling last real zero (if any)
    if pmodulo(nzr, 2) == 1 then
      SOS(nzc + floor(nzr / 2) + 1, 1:3) = [0, 1, -zr($)];
    end

    // Completing SOS if needed (sections without pole or zero)
    if npc + ceil(npr / 2) > nzc + ceil(nzr / 2) then
      for count = nzc + ceil(nzr / 2) + 1 : npc + ceil(npr / 2) // sections without zero
        SOS(count, 1:3) = [0, 0, 1];
      end
    else
      for count = npc + ceil(npr / 2) + 1 : nzc + ceil(nzr / 2) // sections without pole
        SOS(count, 4:6) = [0, 0, 1];
      end
    end
  end

  if ~exists('SOS') then
    SOS = [0, 0, 1, 0, 0, 1]; // leading zeros will be removed
  end

  // Removing leading zeros if present in numerator and denominator
  for count = 1:size(SOS, 1)
    B = SOS(count, 1:3);
    A = SOS(count, 4:6);
    while B(1) == 0 & A(1) == 0 do
      A(1) = [];
      A($ + 1) = 0;
      B(1) = [];
      B($ + 1) = 0;
    end
    SOS(count, :) = [B, A];
  end

  // If no output argument for the overall gain, combine it into the first section.
  if argn(1) < 2 then
    SOS(1, 1:3) = k * SOS(1, 1:3);
  else
    G = k;
  end
endfunction

//tests
//sos = zp2sos ([]);
//sos = zp2sos ([], []);
//sos = zp2sos ([], [], 2);
//[sos, g] = zp2sos ([], [], 2);
//sos = zp2sos([], [0], 1);
//sos = zp2sos([0], [], 1);
//sos = zp2sos([1,2,3,4,5,6], 2);
//sos = zp2sos([-1-%i, -1+%i], [-1-2*%i, -1+2*%i], 10);
