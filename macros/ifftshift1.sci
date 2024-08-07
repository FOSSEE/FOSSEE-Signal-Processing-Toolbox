function y = ifftshift1(x, dim)
//Undo the action of the 'fftshift1' function.
//Calling Sequence:
// ifftshift1(x)
// ifftshift1(x, dim)
//Parameters:
//x- It is a vector of N elements corresponding to time samples
//dim- The optional DIM argument can be used to limit the dimension along which the permutation occurs
//Description:
//Undoes the action of the 'fftshift1' function. For 'x' of even length 'fftshift1' is its own inverse, but odd lengths differ slightly.
//Examples:
//x = [1, 2, 3, 4];
//ifftshift1(fftshift1(x));
//ans =
//[1, 2, 3, 4];

  funcprot(0);
  rhs = argn(2);
  if (rhs < 1 | rhs > 2) then
    error ("ifftshift1: wrong number of arguments");
  end

 if (~or(type(x) == [1 5 8 10 4 6]))
    error ("ifftshitft1: arg1 (x) must be a vector or matrix");
  end

  if (rhs == 1) then
    dim = 1:max(size(size(x)));
  else
    if (~(isscalar(dim) & dim > 0 & dim == fix(dim))) then
      error ("ifftshift1: arg2 (dim) must be a positive integer");
    end
  end

  for d = dim
    sz = size(x);
    sz2 = floor(sz(d) / 2);
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
//assert_checkerror("ifftshift1()", "ifftshift1: wrong number of arguments");
//assert_checkerror("ifftshift1(1, 2, 3)", "Wrong number of input arguments.");
//assert_checkerror("ifftshift1(0:2, -1)", "ifftshift1: arg2 (dim) must be a positive integer");
//assert_checkerror("ifftshift1(0:2, 0:3)", "ifftshift1: arg2 (dim) must be a positive integer");

//test mx1 input:
//x = [0:7];
//y = ifftshift1(x);
//assert_checkequal(y, [4 5 6 7 0 1 2 3]);
//assert_checkequal(ifftshift1(y), x);

//test 1xm input:
//x = [0:6]';
//y = ifftshift1(x);
//assert_checkequal(y, [3;4;5;6;0;1;2]);
//assert_checkequal(ifftshift1(y), [6;0;1;2;3;4;5]);

//test mxn input:
//x = [0:3];
//x = [x;2*x;3*x+1;4*x+1];
//y = ifftshift1(x);
//assert_checkequal(y, [[7 10 1 4];[9 13 1 5];[2 3 0 1];[4 6 0 2]]);
//assert_checkequal(ifftshift1(y), x);

//test dim is provided:
//x = [0:3];
//x = [x;2*x;3*x+1;4*x+1];
//y = ifftshift1(x, 2);
//assert_checkequal(y, [[2 3 0 1];[4 6 0 2];[7 10 1 4];[9 13 1 5]]);
//assert_checkequal(ifftshift1(y, 2), x);
