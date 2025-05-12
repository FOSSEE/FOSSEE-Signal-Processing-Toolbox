function w = nuttallwin (m, opt)
  // Return the filter coefficients of a Blackman-Harris window defined by Nuttall of length m.
//
// Syntax
//   w = nuttallwin(m)
//   w = nuttallwin(m, "periodic")
//   w = nuttallwin(m, "symmetric")
//
// Parameters
// m: Positive integer specifying the length of the window.
// opt: (optional) String specifying the type of window. Possible values are:
//      - "periodic": Returns the periodic form of the window (equivalent to a window of length m+1 with the last coefficient removed).
//      - "symmetric": Default behavior if no second argument is provided.
// w: Vector containing the Nuttall window coefficients.
//
// Description
// The `nuttallwin` function computes the coefficients of a Blackman-Harris window as defined by Nuttall. The window is of length `m`. 
// If the optional argument `"periodic"` is provided, the periodic form of the window is returned. If `"symmetric"` is provided or no 
// second argument is specified, the symmetric form of the window is returned.
//
// // Notes
// - The periodic form of the window is useful for spectral analysis where periodicity is assumed.
// - The symmetric form is typically used for filter design.
// 
// Examples
// 1. Compute a symmetric Nuttall window of length 10:
//    w = nuttallwin(10);
//
// 2. Compute a periodic Nuttall window of length 10:
//    w = nuttallwin(10, "periodic");
//
// 3. Compute a symmetric Nuttall window explicitly:
//    w = nuttallwin(10, "symmetric");
//
//
// Authors
// FOSSEE Team
// toolbox@scilab.in

 funcprot(0);
    rhs= argn(2);

  if (rhs < 1 | rhs > 2)
     error("Wrong Number of input arguments");
  end

  if (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("nuttallwin: M must be a positive integer");
  end

  N = m - 1;
  if (rhs == 2)
    select (opt)
      case "periodic"
        N = m;
      case "symmetric"
        N = m-1;
      else
        error ("nuttallwin: window type must be either periodic or symmetric");
    end
  end

    if (m == 1)
        w = 1;
    else
        a0 = 0.355768;
        a1 = 0.487396;
        a2 = 0.144232;
        a3 = 0.012604;
//        n = [-N/2:(m-1)/2]';
//        w = a0 + a1.*cos(2.*%pi.*n./N) + a2.*cos(4.*%pi.*n./N) + a3.*cos(6.*%pi.*n./N);
        n=[0:m-1]'
        w = a0 - a1.*cos(2.*%pi.*n./N) + a2.*cos(4.*%pi.*n./N) - a3.*cos(6.*%pi.*n./N);
     end

endfunction
