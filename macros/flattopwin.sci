function w = flattopwin (m, opt)

//This function returns the filter coefficients of a Flat Top window.
//Calling Sequence
//w = flattopwin (m)
//w = flattopwin (m, opt)
//Parameters
//m: positive integer value
//opt: string value, takes in "periodic" or "symmetric"
//w: output variable, vector of real numbers
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Flat Top window of length m supplied as input, to the output vector w.
//The second parameter can take the values "periodic" or "symmetric", depending on which the corresponding form of window is returned. The default is symmetric.
//This window has low pass-band ripple but a high bandwidth.
//Examples
//flattopwin(8,"periodic")
//ans  =
//    0.0009051
//  - 0.0264124
//  - 0.0555580
//    0.4435496
//    1.
//    0.4435496
//  - 0.0555580
//  - 0.0264124

 funcprot(0);
    rhs= argn(2);

  if (rhs < 1 | rhs > 2)
    error("Wrong Number of input arguments");
  elseif (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("flattopwin: M must be a positive integer");
  end

  N = m - 1;
  if (rhs == 2)
    select (opt)
      case "periodic"
        N = m;
      case "symmetric"
        N = m - 1;
      else
        error ("flattopwin: window type must be either periodic or symmetric");
    end
  end

  if (m == 1)
    w = 1;
  else
    x = 2*%pi*[0:m-1]'/N;
    w = (1-1.93*cos(x)+1.29*cos(2*x)-0.388*cos(3*x)+0.0322*cos(4*x))/4.6402;
  end

endfunction
