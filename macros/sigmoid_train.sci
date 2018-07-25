function y = sigmoid_train(t, ranges, rc)
// Evaluate a train of sigmoid functions at T.

//Calling Sequence
//y = sigmoid_train(t, ranges, rc)

//Parameters
//t: integer
//ranges: matrix
//rc:timeconstant

//Description
//The number and duration of each sigmoid is determined from RANGES. Each row of RANGES represents a real interval, e.g.  if sigmoid 'i' starts at 't=0.1' and ends at 't=0.5', then 'RANGES(i,:) = [0.1 0.5]'.  The input RC is an array that defines the rising and falling time constants of each sigmoid.  Its size must equal the size of RANGES.

//Examples
//sigmoid_train(0.1,[1:3],4)

//Output :
// ans  =
//
//    0.2737470



funcprot(0);

//**************************************************************************************************
//______________________________________________version1 code (not working)_________________________
//__________________________________________________________________________________________________
//**************************************************************************************************


//rhs=argn(2);
//if (rhs<3 | rhs>3) then
//    error("Wrong number of input arguments");
//end
//
//select(rhs)
//case 3 then
//    y=callOctave("sigmoid_train", t, ranges, rc)
//end


//**************************************************************************************************
//______________________________________________version2 code ( working)____________________________
//__________________________________________________________________________________________________
//**************************************************************************************************

  nRanges = size (ranges, 1);
  if isscalar (rc)

    rc = rc * ones (nRanges,2);

  elseif or( size(rc) ~= [1 1])

    if length(rc) ~= nRanges
      error('signalError','Length of time constant must equal number of ranges.')
    end
    if isrow (rc)
      rc = rc';
    end
    rc = repmat (rc,1,2);

  end


  flag_transposed = %F;
  if iscolumn (t)
    t               = t.';
    flag_transposed = %T;
  end
  [ncol nrow]     = size (t);

  T    = repmat (t, nRanges, 1);
  RC1  = repmat (rc(:,1), 1, nrow);
  RC2  = repmat (rc(:,2), 1, nrow);
  a_up = (repmat (ranges(:,1), 1 ,nrow) - T)./RC1;
  a_dw = (repmat (ranges(:,2), 1 ,nrow) - T)./RC2;


  Y        = 1 ./ ( 1 + exp (a_up) ) .* (1 - 1 ./ ( 1 + exp (a_dw) ) )
  y = max(Y,'r');

  if flag_transposed
    y = y.';
  end

endfunction
