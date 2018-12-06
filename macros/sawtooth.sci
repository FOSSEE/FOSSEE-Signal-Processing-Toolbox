function [y]=sawtooth (t,width)

// Generates a Sawtooth wave
// Calling Sequence
//	[y]=sawtooth(t)
//	[y]=sawtooth(t,width)
// Parameters
//	t: Real valued vector or matrix
//	width: Real number between 0 and 1
// Description
//	This function returns a sawtooth wave with period 2*pi with +1/-1 as the maximum and minimum values for elements of t. If width is specified, it determines where the maximum is in the interval [0,2*pi].
// Examples
// 1.	sawtooth([1 2 3 4 5],0.5)
//	ans =  [-0.36338   0.27324   0.90986   0.45352  -0.18310]
// 2.	sawtooth([1 2; 4 5])
//	ans =  [-0.68169  -0.36338;   0.27324   0.59155]

if (argn(2)<1 | argn(2)>2) then
	error ("Wrong number of input arguments.")
elseif (argn(2)==1)
	width=1
end
  if (width < 0 | width > 1 | ~ isreal (width))
      error ("width must be a real value between 0 and 1");
    end  
 t = pmodulo (t / (2 * %pi), 1);
  y = zeros (size (t,1), size(t,2));

  if (width ~= 0)
    y (t < width) = 2 * t (t < width) / width - 1;
  end
  if (width ~= 1)
    y( t >= width) = -2 * (t (t >= width) - width) / (1 - width) + 1;
  end 
endfunction
