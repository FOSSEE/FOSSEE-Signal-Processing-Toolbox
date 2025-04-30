function w = blackmannuttall(m, opt)
// Generate a Blackman-Nuttall window.
//
// Syntax
//   w = blackmannuttall(m)
//   w = blackmannuttall(m, opt)
//
// Parameters
// m: Positive integer. Length of the Blackman-Nuttall window.
// opt: String. Specifies the type of Blackman-Nuttall window ('symmetric' or 'periodic'). Default is 'symmetric'.
//
// Description
// This function returns the filter coefficients of a Blackman-Nuttall window of length `m`. The second parameter `opt` specifies whether the window is 'symmetric' (default) or 'periodic'.
//
// Examples
// blackmannuttall(5, "symmetric")
// ans =
//    0.0003628
//    0.2269824
//    1.
//    0.2269824
//    0.0003628

 funcprot(0);
    rhs= argn(2);

  if (rhs < 1 | rhs > 2)
     error("Wrong Number of input arguments");
  end

  if (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("blackmannuttall: M must be a positive integer");
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
        a0 = 0.3635819;
        a1 = 0.4891775;
        a2 = 0.1365995;
        a3 = 0.0106411;
//        n = [-N/2:(m-1)/2]';
//        w = a0 + a1.*cos(2.*%pi.*n./N) + a2.*cos(4.*%pi.*n./N) + a3.*cos(6.*%pi.*n./N);
        n=[0:m-1]'
        w = a0 - a1.*cos(2.*%pi.*n./N) + a2.*cos(4.*%pi.*n./N) - a3.*cos(6.*%pi.*n./N);
     end

endfunction
