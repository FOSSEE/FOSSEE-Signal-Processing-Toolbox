function y = sgolayfilt (x, p, n, m, ts)

//This function applies a Savitzky-Golay FIR smoothing filter to the data
//Calling Sequence
//y = sgolayfilt (x)
//y = sgolayfilt (x, p)
//y = sgolayfilt (x, p, n)
//y = sgolayfilt (x, p, n, m)
//y = sgolayfilt (x, p, n, m, ts)
//Parameters 
//x: vector or matrix of real or complex numbers 
//p: polynomial order, real number less than n, default value 3
//n: integer, odd number greater than p
//m: vector of real positive valued numbers, length n
//ts: real number, default value 1 
//Description
//This function applies a Savitzky-Golay FIR smoothing filter to the data given in the vector x; if x is a matrix, this function operates
//on each column. 
//The polynomial order p should be real, less than the size of the frame given by n. 
//m is a weighting vector with default value identity matrix.
//ts is the dimenstion along which the filter operates. If not specified, the function operates along the first non singleton dimension. 
//Examples
//sgolayfilt([1;2;i;4;7], 0.3, 3, 0, 0)
//ans =
//   1.0000 + 0.3333i
//   1.0000 + 0.3333i
//   2.0000 + 0.3333i
//   3.6667 + 0.3333i
//   3.6667 + 0.3333i
//This function is being called from Octave




funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>5)
error("Wrong number of input arguments.")
end


select(rhs)
case 1 then
y = callOctave("sgolayfilt",x)
case 2 then
y = callOctave("sgolayfilt",x, p)
case 3 then
y = callOctave("sgolayfilt",x, p, n)
case 4 then
y = callOctave("sgolayfilt",x, p, n, m)
case 5 then
y = callOctave("sgolayfilt",x, p, n, m, ts)
end
endfunction
