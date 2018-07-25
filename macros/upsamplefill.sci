function y = upsamplefill (x, v, c)
//This function upsamples a vector interleaving given values or copies of the vector elements.
//Calling Sequence
//
//y = upsamplefill (x, w, cpy)
//Parameters
//x: scalar, vector or matrix of real or complex numbers
//w: scalar or vector of real or complex values
//cpy: can take in "true" or "false", default is false
//Description
//This is an Octave function.
//This function upsamples a vector interleaving given values or copies of the vector elements.
//The second argument has the values in the vector w that are placed in between the elements of x.
//The third argument, if true, means that w should be scalar and that each value in x repeated w times.
//Examples

//1.upsamplefill([1,3,5],2,%f)
//ans:1.    1.    1.    3.    3.    3.    5.    5.    5.

//2.upsamplefill([1,3,5],2,%t)
//ans:1.    2.    3.    2.    5.    2.




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
