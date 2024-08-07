function savg = spencer (x)
//Returns Spencer's 15 point moving average of each column of x.
//Calling Sequence:
//spencer(x)
//Parameters:
//X: Real vector or matrix
//Description:
//Returns Spencer's 15 point moving average of each column of x.

  funcprot(0);
  if (nargin() ~= 1)
    error("Wrong number of input arguments.");
  end
  [xr, xc] = size (x);

  n = xr;
  c = xc;

  if (isvector (x))
   n = length (x);
   c = 1;
   x = matrix(x, n, 1);
  end

  end
  w = [-3, -6, -5, 3, 21, 46, 67, 74, 67, 46, 21, 3, -5, -6, -3] / 320;
  savg = filter (w, 1, x);
  savg = [zeros(7,c); savg(15:n,:); zeros(7,c);];
  savg = matrix(savg, xr, xc);

endfunction

//tests:
//assert_checkerror("spencer()", "Wrong number of input arguments.");
//assert_checkerror("spencer(1, 2)", "Wrong number of input arguments.");
//assert_checkequal(spencer(linspace(1, 14, 14)'), zeros(14, 1));
//assert_checkequal(spencer(linspace(-1, -10, 14)), zeros(1, 14)); 
