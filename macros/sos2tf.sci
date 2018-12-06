function [A,B] = sos2tf(sos, g)
//This function converts series second-order sections to direct H(z) = B(z)/A(z) form.
//Calling Sequence
//[B] = sos2tf(sos)
//[B] = sos2tf(sos, g)
//[B,A] = sos2tf(...)
//Parameters 
//sos: matrix of real or complex numbers
//g: real or complex value, default value is 1
//Description
//This function converts series second-order sections to direct H(z) = B(z)/A(z) form.
//The input is the sos matrix and the second parameter is the overall gain, default value of which is 1. 
//The output is a vector.
//Examples
//sos = [1  1  1  1  0 -1; -2  3  1  1 10  1];
////[b,a] = sos2tf(sos)
//a =
//  -2   1  2  4  1
//b =
//   1 10  0 -10 -1
if(argn(2)<1 | argn(2)>2)
error("Wrong number of input arguments.")
end

if argn(2)==1 then
    g=1;
end

  [N,M] = size(sos);

  if M~=6
    error('sos matrix must be N by 6');
  end

  A = 1;
  B = 1;

  for i=1:N
    A = conv(A, sos(i,1:3));
    B = conv(B, sos(i,4:6));
  end

  nB = length(A);
  
  while nB & A(nB)==0
    A=A(1:nB-1);
    nB=length(A);
  end

  nA = length(B);
  while nA & B(nA)==0
    B=B(1:nA-1);
    nA=length(B);
  end
  A = A * g;

endfunction
