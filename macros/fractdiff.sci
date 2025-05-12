function y= fractdiff(x,d)
// Compute the fractional differences (1-L)^d x where L denotes the lag-operator and d is greater than -1.
//
// Syntax
//   y = fractdiff(x, d)
//
// Parameters
// x: Vector. The input series to be differenced.
// d: Scalar. The fractional differencing parameter. Must be greater than -1.
// y: Vector. The fractionally differenced series.
//
// Description
// This function computes the fractional differences (1-L)^d x, where L denotes the lag-operator and d is greater than -1.
//
// Examples
// y = fractdiff([1, 2, 3, 4], 0.5)
//

if(argn(2)~=2)
	error("Wrong number of input arguments");
end


N = 100;

  if (~ isvector (x) | ~isscalar(d))
    error ("X must be a vector and D must be a scalar");
  end
  
  if (d<= -1) then
      error ("D must be > -1");
  end
  
  if (d >= 1)
    for k = 1 : d
      x = x(2 : length (x)) - x(1 : length (x) - 1);
    end
  end
//disp(x)
  if (d >-1)
       d=d-fix(d./1).*1;
//disp(d)
    if (d ~= 0)
      n = (0 : N)';
      w = real (gamma (-d+n) ./ gamma (-d) ./ gamma (n+1));
    //  disp(w); disp(x)
      y = fftfilt (w, x);
      y = y(1 : length (x));
    else
             // disp(x)
      y = x;
    end

  end
  
  
endfunction
