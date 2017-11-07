//Prony's method for time-domain design of IIR Filters
//[b,a]=prony(h,nb,na)
//where b= coefficients of the numerator of the TF
//    a=coefficients of the denominator of the TF
//    h=impulse response of the digital filter
//    nb=number of zeros
//    na=number of poles
//Reference : T.W. Parks and C.S. Burrus, Digital Filter Design,
//       John Wiley and Sons, 1987, p226.
//Author 
//Debdeep Dey
function [b,a]=prony(h,nb,na)

K = length(h)-1;
M=double(nb);
N=double(na);
//zero-pad input if necessary
if K <= max(M,N) then     
        K = max(M,N)+1;
        h(K+1) = 0;
end
c = h(1);
if c==0    //avoid division by zero
    c=1;
end
H = toeplitz(h/c,[1 zeros(1,K)]);
//K+1 by N+1
if (K > N)
    H(:,(N+2):(K+1)) = [];
end
//Partition H matrix
H1 = H(1:(M+1),:);	//M+1 by N+1
h1 = H((M+2):(K+1),1);	//K-M by 1
H2 = H((M+2):(K+1),2:(N+1));	//K-M by N
a = [1; -H2\h1].';
b = c*a*H1.';

endfunction

