function [v, rg] = schtrig (x, lvl, rst)
//This function implements a multisignal Schmitt triggers with 'lvl' levels supplied as input.
//Calling Sequence:
//x = schtrig(x, lvl)
//lvl = schtrig(x, lvl, rst)
//Parameters:
//x: Vector or matrix of real numbers
//lvl: Real number
//rst: Boolean, default value is 'true'
//Description:
//This function implements a multisignal Schmitt triggers with 'lvl' levels supplied as input.
//The argument 1 is a matrix (or a vector) and this trigger works along its first dimension.
//Examples:
//schtrig([0.2,-3,5], -4)
//ans = [0, 0, 1]

  funcprot(0);
  warning('off');
  if (argn(2) < 2 | argn(2) > 3)
    error("Wrong number of input arguments.");
  elseif (argn(2) == 2)
    rst = %T;
  end
  if (length (ndims (x)) > 2)
    error ('The input should be two dimensional.');
  end
  if (length (ndims (lvl)) > 2)
    error ('Only a maximum of two threshold levels accepted.');
  end

  [nT nc] = size (x);

  global st0;
  if (rst || isempty (st0))
    st0 = zeros (1,nc);
  end

  if (length(lvl) == 1)
    lvl = abs (lvl) .* [1 -1];
  else
    lvl = gsort(lvl, 'g', 'd');
  end

  v      = repmat(%nan, nT, nc);
  v(1,:) = st0;

  up    = x > lvl(1);
  v(up) = 1;

  dw    = x < lvl(2);
  v(dw) = 0;

  idx    = bool2s(isnan(v));
  xhi = idx';
  bool_discon = diff (xhi, 1, 2);
  [Np Na]     = size (xhi);
  ranges   = cell (1, Np);

  for i = 1:Np
    idxUp  = find (bool_discon(i,:) > 0) + 1;
    idxDwn = find (bool_discon(i,:) < 0);
    tLen   = length (idxUp) + length (idxDwn);

    if (xhi(i,1) == 1)
      ranges{i}(1) = 1;
      ranges{i}(2:2:tLen+1) = idxDwn;
      ranges{i}(3:2:tLen+1) = idxUp;
    else
      ranges{i}(1:2:tLen) = idxUp;
      ranges{i}(2:2:tLen) = idxDwn;
    end

    if (xhi(i, $) == 1)
      ranges{i}($+1) = Na;
    end

    tLen = length(ranges{i});
    if (tLen ~= 0)
      ranges{i} = matrix(ranges{i}, 2, tLen / 2);
    end

  end

  if (Np == 1)
    ranges = cell2mat(ranges);
  end
  if (nc == 1)
    ranges = {ranges};
  end

  for i=1:nc
    if (~isempty(ranges{i}))
      prev         = ranges{i}(1,:)-1;
      prev(prev<1) = 1;
      st0          = v(prev, i);
      ini_idx = ranges{i}(1,:);
      end_idx = ranges{i}(2,:);
      for j =1:length(ini_idx)
        v(ini_idx(j):end_idx(j),i) = st0(j);
      end
    end
  end

  st0 = v($, :);

endfunction

//input validation:
//assert_checkerror("schtrig(1)", "Wrong number of input arguments.");
//assert_checkerror("schtrig(1, 2, 3, 4)", "Wrong number of input arguments.");

//tests:
//assert_checkequal(schtrig(ones(128, 1), -1), zeros(128, 1));
//assert_checkequal(schtrig(ones(128, 1), -1), schtrig(ones(128, 1), -1, %F));
//
//assert_checkequal(schtrig([1 5 1], 3), schtrig([1 5 1], 3, %T));
//assert_checkequal(schtrig([1 5 1], 3), [0 1 0]);
//assert_checkequal(schtrig([1 5 1], 3, %F), schtrig([1 5 1], 3));
//
//assert_checkequal(schtrig([-3; 4; -1], -2), [0; 1; 1]);
//assert_checkequal(schtrig([-3; 4; -1], -2, %F), schtrig([-3; 4; -1], -2));
//
//assert_checkequal(schtrig([1 -3; 2 4; 5 -1], -2), [0 0; 0 1; 1 1]);
//assert_checkequal(schtrig([1 -3; 2 4; 5 -1], -2, %F), [1 0; 1 1; 1 1]);
//
//assert_checkequal(schtrig([1.1 1.5 0; 0.53 1.21 3.57; 5.34 -1.24 0], 0.424), [1 1 0;1 1 1;1 0 1]);
//assert_checkequal(schtrig([1.1 1.5 0; 0.53 -1.21 3.57; 5.34 -1.24 0], 0.424, %F), [1 1 1;1 0 1;1 0 1]);
