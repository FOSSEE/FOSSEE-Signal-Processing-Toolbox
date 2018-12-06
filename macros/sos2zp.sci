function [z,p,k] = sos2zp (sos, g)
//This function converts series second-order sections to zeros, poles, and gains (pole residues).
//Calling Sequence
//z = sos2zp (sos)
//z = sos2zp (sos, g)
//[z, p] = sos2zp (...)
//[z, p, k] = sos2zp (...)
//Parameters 
//sos: matrix of real or complex numbers
//g: real or complex value, default value is 1
//z: column vector
//p: column vector
//Description
//This function converts series second-order sections to zeros, poles, and gains (pole residues).
//The input is the sos matrix and the second parameter is the overall gain, default value of which is 1.
//The outputs are z, p, k. z and p are column vectors containing zeros and poles respectively, and k is the overall gain. 
//Examples
//[a,b,c]=sos2zp([1,2,3,4,5,6])
//a =
//  -1.0000 + 1.4142i
//  -1.0000 - 1.4142i
//b =
//  -0.6250 + 1.0533i
//  -0.6250 - 1.0533i
//c =  1
if(argn(2)<1 | argn(2)>2)
error("Wrong number of input arguments.")
end
if argn(2)==1 then
    g=1;
end
  gns = sos(:,1); 
  k = prod(gns)*g; 
  if k==0 then
     error('one or more section gains is zero'); 
     end
  sos(:,1:3) = sos(:,1:3)./ [gns gns gns];

  [N,m] = size(sos);
  if m~=6 then
      error('sos matrix should be N by 6'); 
      end

  z = zeros(2*N,1);
  p = zeros(2*N,1);
  for i=1:N
    ndx = [2*i-1:2*i];
    zi = roots(sos(i,1:3));
    z(ndx) = zi;
    pi = roots(sos(i,4:6));
    p(ndx) = pi;
  end

endfunction
