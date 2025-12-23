function w = tukeywin(m, varargin)
// This function returns the filter coefficients of a Tukey window.
//
// Syntax
//   w = tukeywin(n)
//   w = tukeywin(n, r)
//
// Parameters
// n: Window length.
// r: Taper ratio. Default is 0.5.
// w: Tukey window.
//
// Description
// This function generates a Tukey window of length `n` with taper ratio `r`.
//
// Examples
// w = tukeywin(64, 0.5)
//
// See also
//  hanning
//


 funcprot(0);
    [nargout,nargin]=argn();


  if (nargin < 1 | nargin > 2)
    error("Wrong Number of input arguments");
  elseif (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("tukeywin: M must be a positive integer");
  elseif (nargin == 2)
    // check that 0 < r < 1
    r=varargin(1);
    if r > 1
      r = 1;
    elseif r < 0
      r = 0;
    end
  else
      r=0.5;
  end

      //generate window
  select(r)
    case 0,
      //full box
      w = ones (m, 1);
    case 1,
     // Hanning window
      w = hanning (m);
    else
      // cosine-tapered window
      t = linspace(0,1,m);
      t = t(1:$/2)';
      w = (1 + cos(%pi*(2*t/r-1)))/2;
      w(floor(r*(m-1)/2)+2:$) = 1;
      w = [w; ones(modulo(m,2)); w($:-1:1,:)];
  end

endfunction
