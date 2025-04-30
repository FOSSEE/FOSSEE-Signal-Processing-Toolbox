function y = decimate(x, r, varargin)
// Short description on the first line following the function header.
//
// Syntax
//   y = decimate(x, r)
//   y = decimate(x, r, n)
//   y = decimate(x, r, n, 'fir')
//
// Parameters
// x: Input signal vector.
// r: Decimation factor.
// n: Filter order. Default is 8.
// y: Decimated signal.
//
// Description
// This function reduces the sampling rate of a signal by a factor of `r` using an anti-aliasing filter.
//
// Examples
// y = decimate([1, 2, 3, 4, 5], 2)
//
// See also
//  resample, interp
//
// Authors
//  Author name ; should be listed one pr line. Use ";" to separate names from additional information 
//
// Bibliography
//   Literature references one pr. line

rhs = argn(2)
if(rhs<2 | rhs>4)
error("Wrong number of input arguments.")
elseif(~(sum(length(r)==1) & r == fix (r) & r > 0))
error("Parameter 2 must be a positive integer.")
end
//if (nargin < 3)
if(argn(2) < 3)
ftype = "iir"
n = []
//elseif (nargin < 4)
elseif(argn(2) < 4)
if (ischar (n))
ftype = n
n = []
else
ftype = "iir"
end
end

//if (~ and(strcmp (ftype, {"fir", "iir"})))    // if strings are equal strcmp returns 0
if(strcmp(ftype,"iir") & strcmp(ftype,"fir"))
error("Filter type must be either fir or iir.")
end

fir = strcmp (ftype, "fir")
if (isempty (n))
if (fir)
n = 30
else
n = 8
end
end

if(~(sum(length(n)==1) & n == fix (n) & n > 0))
error("N must be a positive integer.")
end
select(rhs)
case 2 then
y = callOctave("decimate", x, r)
case 3 then
y = callOctave("decimate", x, r, n)
case 4 then
y = callOctave("decimate", x, r, n, ftype)
end
endfunction
