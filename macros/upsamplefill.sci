function y = upsamplefill (x, v, c)
// Upsample a vector by interleaving given values or copies of the vector elements.
//
// Syntax
//   y = upsamplefill(x, w, cpy)
//
// Parameters
// x: Scalar, vector, or matrix of real or complex numbers.
// w: Scalar or vector of real or complex values. Specifies the values to be interleaved between the elements of `x`.
// cpy: Boolean (`%t` or `%f`). If `%t`, `w` must be scalar, and each value in `x` is repeated `w` times. Default is `%f`.
//
// Outputs
// y: Upsampled vector or matrix with interleaved values or repeated elements.
//
// Description
// The `upsamplefill` function upsamples a vector or matrix by interleaving specified values or repeating elements. 
// If `cpy` is `%f`, the values in `w` are interleaved between the elements of `x`. If `cpy` is `%t`, each value in `x` 
// is repeated `w` times.
//
// Examples
// // Upsample a vector by repeating elements:
//    x = [1, 3, 5];
//    y = upsamplefill(x, 2, %f)
//    // Output: y = [1, 1, 1, 3, 3, 3, 5, 5, 5]
//
// // Upsample a vector by interleaving values:
//    x = [1, 3, 5];
//    y = upsamplefill(x, 2, %t)
//    // Output: y = [1, 2, 3, 2, 5, 2]
//




  if argn(2)<2
    error("wrong no. of input arguments")
  end

  [nr,nc] = size (x);
  if c==%f

    if  (nr==1 | nc==1)

      y = kron (x(:), ones(v+1,1));
      if nr == 1
        y = y.';
      end

    else

      y = kron (x, ones(v+1,1));

    end

    return

  else

  //Assumes 'v' row or column vector
    n = length(v) + 1;
    N = n*nr;

    if (nr==1 | nc==1)

      N        = N*nc;
      idx      = 1:n:N;
      idx_c    = setdiff (1:N, 1:n:N);
      y        = zeros (N,1);
      y(idx) = x';
      y(idx_c) = repmat (v(:), max(nr,nc), 1);

      if nr == 1
        y = y.';
      end

    else

      idx      = 1:n:N;
      idx_c    = setdiff(1:N,1:n:N);
      y        = zeros (N,nc);
      y(idx,:)   = x';

      y(idx_c,:) = repmat (v(:), nr, nc);

    end
  end

endfunction
