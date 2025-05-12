
function [b,a]=prony(h,nb,na)
// Prony's method for time-domain design of IIR Filters.
//
// Syntax
//   [b, a] = prony(h, nb, na)
//
// Parameters
// h: Impulse response of the digital filter (vector).
// nb: Number of zeros (integer).
// na: Number of poles (integer).
//
// Description
// The `prony` function designs an IIR filter using Prony's method. It computes the coefficients of the numerator (`b`) 
// and denominator (`a`) of the transfer function (TF) based on the given impulse response `h`, number of zeros `nb`, 
// and number of poles `na`.
//
// Notes
// - The function zero-pads the input `h` if its length is less than `max(nb, na) + 1`.
// - The method avoids division by zero by normalizing the first element of `h`.
//
// Examples
// // Design an IIR filter with 1 zero and 2 poles:
//    V = filter([1, 1], [1, 1, 2], [1 zeros(1, 31)]); // Impulse response
//    [b, a] = prony(V, 1, 2)
//    // Output:
//    // a = [1, 1, 2] // Denominator coefficients
//    // b = [1, 1]    // Numerator coefficients
//
// // Design an IIR filter with 1 zero and 3 poles:
//    V = filter([1, 2], [1, 2, 3, 4], [1 zeros(1, 31)]);
//    [b, a] = prony(V, 1, 3)
//    // Output:
//    // a = [1, 2, 3, 4] // Denominator coefficients
//    // b = [1, 2]       // Numerator coefficients
//
// Bibliography
// T.W. Parks and C.S. Burrus, Digital Filter Design, John Wiley and Sons, 1987, p226.
//
// Authors
// Debdeep Dey




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
