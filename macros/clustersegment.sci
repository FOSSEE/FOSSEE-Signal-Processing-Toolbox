function contRange = clustersegment(xhi)
//This function calculates boundary indexes of clusters of 1’s.
//Calling Sequence:
//contRange = clustersegment(xhi)
//Parameters 
//xhi: scalar, vector or matrix of real numbers (clusters of 1s) 
//contRange: output variable, cell array of size 1 by Np, where Np is the number of rows in 'xhi'
//Description:
//This function calculates boundary indexes of clusters of 1’s.
//This function calculates the initial and end indices of the sequences of 1's present in the input argument.
//The output variable 'contRange' is a cell array of size 1 by Np, where Np is the number of rows in 'xhi' and each element has two rows indicating the initial index and end index of the cluster of 1's respectively. The indexing starts from 1.
//Examples:
//y = clustersegment([0,1,0,0,1,1])
//y  =
//    2.    5.  
//    2.    6.

  funcprot(0);
  if (argn(2) ~= 1)
      error("Wrong number of input arguments.");
  end
  warning('off');
  
  bool_discon = diff (xhi, 1, 2);
  [Np Na]     = size (xhi);
  contRange   = cell (1, Np);

  for i = 1:Np
    idxUp  = find (bool_discon(i,:) > 0) + 1;
    idxDwn = find (bool_discon(i,:) < 0);
    tLen   = length (idxUp) + length (idxDwn);

    if (xhi(i,1) == 1)
      contRange{i}(1)          = 1;
      contRange{i}(2:2:tLen+1) = idxDwn;
      contRange{i}(3:2:tLen+1) = idxUp;
    else
      contRange{i}(1:2:tLen) = idxUp;
      contRange{i}(2:2:tLen) = idxDwn;
    end

    if (xhi(i, $) == 1)
      contRange{i}($+1) = Na;
    end

    tLen = length (contRange{i});
    if (tLen ~= 0)
      contRange{i} = matrix(contRange{i}, 2, tLen / 2);
    end

  end

  if (Np == 1)
    contRange = cell2mat (contRange);
  end

endfunction

//tests:
//assert_checkerror("clustersegment()", "Wrong number of input arguments.");
//assert_checkerror("clustersegment(1, 2)", "Wrong number of input arguments.");
//
//assert_checkequal(clustersegment(1), [1; 1]);
//assert_checkequal(clustersegment(-5), []);
//assert_checkequal(clustersegment(3*%i), []);
//assert_checkequal(clustersegment([0 0 1 1 1 0 0 1 0 0 0 1 1]), [3 8 12; 5 8 13]);
//
//ranges = clustersegment([-1; 1; 2; 1]);
//assert_checkequal(ranges{1, 1}, []);
//assert_checkequal(ranges{1, 2}, [1; 1]);
//assert_checkequal(ranges{1, 3}, []);
//assert_checkequal(ranges{1, 4}, [1; 1]);
//
//ranges = clustersegment([-1-2*%i; 1; 2*%i; 3+4*%i])
//assert_checkequal(ranges{1, 1}, []);
//assert_checkequal(ranges{1, 2}, [1; 1]);
//assert_checkequal(ranges{1, 3}, []);
//assert_checkequal(ranges{1, 4}, []);
//
//ranges = clustersegment([-1 1 1; 1 -1 1; -1 -1 1])
//assert_checkequal(ranges{1, 1}, [2; 3]);
//assert_checkequal(ranges{1, 2}, [1 3; 1 3]);
//assert_checkequal(ranges{1, 3}, [3; 3]);
