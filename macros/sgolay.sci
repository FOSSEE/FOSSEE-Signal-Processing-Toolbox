function F = sgolay (p, n, m, ts)
//This function computes the filter coefficients for all Savitzsky-Golay smoothing filters. 
//Calling Sequence
//F = sgolay (p, n)
//F = sgolay (p, n, m)
//F = sgolay (p, n, m, ts)
//Parameters 
//p: polynomial 
//n: odd integer value, larger than polynomial p
//m: positive integer less than 2^31 or logical
//ts: real or complex value
//Description
//This function computes the filter coefficients for all Savitzsky-Golay smoothing filters of order p for length n (odd). 
//m can be used in order to get directly the mth derivative; ts is a scaling factor.
//Examples
//y = sgolay(1,3,0)
//y =
//   0.83333   0.33333  -0.16667
//   0.33333   0.33333   0.33333
//  -0.16667   0.33333   0.83333

if(argn(2)<2 | argn(2)>4) then
error("Wrong number of input arguments.")
elseif ((n-fix(n./2).*2)~=1)  then
error ("sgolay needs an odd filter length n");
elseif (p>=n) then
     error ("sgolay needs filter length n larger than polynomial order p");
 end

if (argn(2)==2) then
    m=0; ts=1;
end
if (argn(2)==3) then
    ts=1;
end

if length(m) > 1, error("weight vector unimplemented"); end

 F = zeros (n, n);
 k = floor (n/2);
    for row = 1:k+1
      C = ( [(1:n)-row]'*ones(1,p+1) ) .^ ( ones(n,1)*[0:p] );   
      A = pinv(C);   
      F(row,:) = A(1+m,:);
    end

  F(k+2:n,:) = (-1)^m*F(k:-1:1,n:-1:1);
  F =  F * ( prod(1:m) / (ts^m) );

endfunction
