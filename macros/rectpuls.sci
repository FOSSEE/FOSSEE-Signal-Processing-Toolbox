function [y]=rectpuls(t,w)
// Generates a Rectangular pulse based on the width and sampling times.
// 
// Syntax
//	[y]=rectpuls(t)
//	[y]=rectpuls(t,w)
// 
// Parameters
//	t: Real or complex valued vector or matrix
//	w: Real or complex valued vector or matrix
// 
// Description
//	y = rectpuls(t) returns a continuous, aperiodic, unity-height rectangular pulse depending upon input t, centered about t=0 and having default width of 1.
//	y = rectpuls(t,w) generates a rectangle of width w.
// 
// Examples
// 	rectpuls([10 100 1000 13 839],27)
// 

if (argn(2)<1 | argn(2)>2) then
	error ("Wrong number of input arguments.")
elseif (argn(2)==1) then
	w=1;
end

  if (~ isreal (w) | ~ isscalar (w))
    error ("W must be a real scalar");
  end
  
y = zeros (size(t,1), size(t,2));
idx = find ((t >= -w/2) & (t < w/2));
y(idx) = 1;
endfunction
