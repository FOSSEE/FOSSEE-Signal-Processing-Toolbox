function y = decimate(x, q, n, ftype)
rhs = argn(2)
if(rhs<2 | rhs>4)
error("Wrong number of input arguments.")
elseif(~(sum(length(q)==1) & q == fix (q) & q > 0))
error("Parameter 2 must be a positive integer.")
end
if (nargin < 3)
ftype = "iir"
n = []
elseif (nargin < 4)
if (ischar (n))
ftype = n
n = []
else
ftype = "iir"
end
end

if (~ and(strcmp (ftype, {"fir", "iir"})))
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
y = callOctave("decimate", x, q)
case 3 then
y = callOctave("decimate", x, q, n)
case 4 then
y = callOctave("decimate", x, q, n, ftype)
end
endfunction



