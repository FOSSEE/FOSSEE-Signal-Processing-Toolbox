function y = decimate(x, q, n, ftype)
//Decimation — decrease sample rate by integer factor

//Calling Sequence
//y = decimate(x,q)
//y = decimate(x,q,n)
// y = decimate (…, "fir")

//Parameters
//x: input sequence
//q: reduction factor
//n : filter order
//ftype: filter type : iir or fir

//Description
//this is an octave function
//y = decimate(x,q) reduces the sample rate of x, the input signal, by a factor of q.
//By default, an order n Chebyshev type I filter is used. If n is not specified, the default is 8.
//If the optional argument "fir" is given, an order n FIR filter is used, with a default order of 30 if n is not given.
//Note that q must be an integer for this rate change method.
//
//Example :
//t = 0:.00025:1;
//x = sin(2*%pi*30*t) + sin(2*%pi*60*t);
//y = decimate(x,4);
//subplot(211);
//plot2d3((0:120),x(1:121));
//subplot(212);
//plot2d3((0:30),y(1:31));

//This will result in plots of original sequence v/s sample number and decimated sequence v/s sample number

rhs = argn(2)
if(rhs<2 | rhs>4)
error("Wrong number of input arguments.")
elseif(~(sum(length(q)==1) & q == fix (q) & q > 0))
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
y = callOctave("decimate", x, q)
case 3 then
y = callOctave("decimate", x, q, n)
case 4 then
y = callOctave("decimate", x, q, n, ftype)
end
endfunction
