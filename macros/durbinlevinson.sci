function [newphi, newv] = durbinlevinson (c, oldphi, oldv)
// Perform one step of the Durbin-Levinson algorithm.
//Calling Sequence
// durbinlevinson(c)
// durbinlevinson(c, oldphi)
// durbinlevinson(c, oldphi, oldv)
//Parameters:
//c: The vector c specifies the autocovariances '[gamma_0, ..., gamma_t]' from lag 0 to t.
//oldphi: It specifies the coefficients based on c(t-1).
//oldv: It specifies the corresponding error.
//Description:
//Perform one step of the Durbin-Levinson.
//If 'oldphi' and 'oldv' are omitted, all steps from 1 to t of the algorithm are performed.
//Example:
//durbinlevinson([1, 2, 3], 1, 2)
//ans = [0.5, 0.5]

  funcprot(0);
  rhs = argn(2);

  if (rhs ~= 1 & rhs ~= 3)
    error("durbinlevinson: wrong number of input arguments");
  end

  if (size(c, 'c') > 1)
    c = c';
  end

  newphi = 0;
  newv = 0;

  if (rhs == 3)
    t = length (oldphi) + 1;
    if (length (c) < t + 1)
      error ("durbinlevinson: arg1 (c) is too small");
    end

    if (oldv == 0)
      error ("durbinlevinson: arg3 (oldv) must be non-zero");
    end

    if (size(oldphi, 'r') > 1)
      oldphi = oldphi';
    end

    newphi = zeros (1, t);
    newphi(1) = (c(t+1) - oldphi * c(2:t)) / oldv;
    for i = 2 : t
      newphi(i) = oldphi(i-1) - newphi(1) * oldphi(t-i+1);
    end
    newv = (1 - newphi(1)^2) * oldv;

  else
    tt = length (c)-1;
    oldphi = c(2) / c(1);
    oldv = (1 - oldphi^2) * c(1);

    for t = 2 : tt
      newphi = zeros (1, t);
      newphi(1) = (c(t+1) - oldphi * c(2:t)) / oldv;
      for i = 2 : t
        newphi(i) = oldphi(i-1) - newphi(1) * oldphi(t-i+1);
      end
      newv = (1 - newphi(1)^2) * oldv;
      oldv = newv;
      oldphi = newphi;
    end
  
  end
endfunction

//input validation:
//assert_checkerror("durbinlevinson()", "durbinlevinson: wrong number of input arguments");
//assert_checkerror("durbinlevinson(1, 2, 3, 4)", "Wrong number of input arguments.");
//assert_checkerror("durbinlevinson([1, 2], [1, 2, 3], 5)", "durbinlevinson: arg1 (c) is too small");
//assert_checkerror("durbinlevinson([1, 2, 3, 4], [1, 2], 0)", "durbinlevinson: arg3 (oldv) must be non-zero");

//test mx1 input:
//assert_checkequal(durbinlevinson([2, 4, 3]), durbinlevinson([2, 4, 3], 2, -6));
//assert_checkequal(durbinlevinson([9, 12, 43, 55], 3, -4), [-1.75, 8.25]);
//assert_checkequal(durbinlevinson([2, 5, 3, 5, 7], [2, 6], -4), [5.75, -32.5, -5.5]);
//assert_checkequal(durbinlevinson([6, 5, 8, 4], [1; 2], -1), [17, -33, -15]);

//test 1xm input:
//assert_checkequal(durbinlevinson([1; 4; 7]), [0.6, 1.6]);
//assert_checkequal(durbinlevinson([3; 6; 7], -5, -2), [-18.5, -97.5]);
//assert_checkequal(durbinlevinson([3; 6; 4; 2; 1; 9], [4; 6; 5], 3), [-19, 99, 120, 81]);
//assert_checkequal(durbinlevinson([6; 5; 8; 4], [1, 2], -1), [17, -33, -15]);
