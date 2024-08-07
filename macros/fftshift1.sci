function y = fftshift1(x, dim)
//Performs a shift of the vector x, for use with the fft1 and ifft1 functions, in order to move the frequency 0 to the center of the vector or matrix.
//Calling Sequence:
// fftshift1(x)
// fftshift1(x, dim)
//Parameters:
//x- It is a vector of N elements corresponding to time samples
//dim- The optional DIM argument can be used to limit the dimension along which the permutation occurs
//Examples:
//x = [0:6]
//fftshift1(x)
//ans =
//4 5 6 0 1 2 3

  funcprot(0);
  rhs = argn(2);
  if (rhs < 1 | rhs > 2) then
    error ("fftshift1: wrong number of arguments");
  end

 if (~or(type(x) == [1 5 8 10 4 6]))
    error ("fftshitft1: arg1 (x) must be a vector or matrix");
  end

  if (rhs == 1) then
    dim = 1:max(size(size(x)));
  else
    if (~(isscalar(dim) & dim > 0 & dim == fix(dim))) then
      error ("fftshift1: arg2 (dim) must be a positive integer");
    end
  end

  for d = dim
    sz = size(x);
    sz2 = ceil(sz(d) / 2);
    dim_idx = [sz2+1:sz(d), 1:sz2];
    if (d == 1) then
      x = x(dim_idx, :);
    elseif ( d == max(size(size(x))) ) then
      x = x(:, dim_idx);
    else
      idx = repmat({':'}, 1, max(size(size(x))));
      idx(d) = {dim_idx};
      x = x(idx{:});
    end
  end
  y = x;

endfunction

//input validation:
//assert_checkerror("fftshift1()", "fftshift1: wrong number of arguments");
//assert_checkerror("fftshift1(1, 2, 3)", "Wrong number of input arguments.");
//assert_checkerror("fftshift1(0:2, -1)", "fftshift1: arg2 (dim) must be a positive integer");
//assert_checkerror("fftshift1(0:2, 0:3)", "fftshift1: arg2 (dim) must be a positive integer");

//test mx1 input:
//x = [0:7];
//y = fftshift1 (x);
//assert_checkequal (y, [4 5 6 7 0 1 2 3]);
//assert_checkequal (fftshift1(y), x);

//test 1xm input:
//x = [0:7]';
//y = fftshift1(x);
//assert_checkequal(y, [4;5;6;7;0;1;2;3]);
//assert_checkequal(fftshift1(y), x);

//test mxn input:
//x = [0:3];
//x = [x;2*x;3*x+1;4*x+1];
//y = fftshift1(x);
//assert_checkequal(y, [[7 10 1 4];[9 13 1 5];[2 3 0 1];[4 6 0 2]]);
//assert_checkequal(fftshift1(y), x);

//test dim is provided:
//x = [0:3];
//x = [x;2*x;3*x+1;4*x+1];
//y = fftshift1(x, 1);
//assert_checkequal(y, [[1 4 7 10];[1 5 9 13];[0 1 2 3];[0 2 4 6]]);
//assert_checkequal(fftshift1(y, 1), x);
