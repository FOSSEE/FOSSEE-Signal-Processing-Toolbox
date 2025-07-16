function [k,e] = schurrc(R)
// Schur algorithm for computing reflection coefficients and prediction error variance.
//
// Syntax
//   [k, e] = schurrc(R)
//
// Parameters
// R: Autocorrelation vector or matrix. If `R` is a matrix, the function computes the reflection coefficients 
//    for each column of `R` and returns them in the columns of `k`.
// k: Reflection coefficients (matrix). Each column corresponds to the reflection coefficients for the respective column of `R`.
// e: Prediction error variance (vector). Each row corresponds to the prediction error variance for the respective column of `R`.
//
// Description
// The `schurrc` function computes the reflection coefficients and prediction error variance using Schur's algorithm. 
// If the input `R` is a matrix, the function processes each column independently.
//
// Examples
// // Compute reflection coefficients and prediction error variance:
//    m = linspace(1, 100);
//    r = xcorr(m(1:5), 'unbiased') // Autocorrelation vector
//    [k, e] = schurrc(r(5:$))


    narginchk(1,1,argn(2));
if(type(R)==10) then// R is a matrix of character strings
    w=R;
    [nr,nc]=size(R);
    if(nr==1 & nc==1) then
        R=ascii(R);//conversion to the corresponding asci values
        R=matrix(R,length(w));//reshaping the matrix
    else

        R=ascii(R);
        R=matrix(R,size(w));//reshaping the matrix
    end

end
if(type(R) > 1) then   ///checking if R in not a matrix of real or complex numbers
	error('Input R is not a matrix')
end
if (min(size(R)) == 1) then
    R = R(:);
end
[m,n] = size(R);
// Compute reflection coefficients for each column of the input matrix
for j = 1:n
	X = R(:,j).';
	// Schur's iterative algorithm on a row vector of autocorrelation values
	U = [0 X(2:m); X(1:m)];

    for i = 2:m,
        U(2,:) = [0 U(2,1:m-1)];
        k(i-1,j) = -U(1,i)/U(2,i);
        U = [1 k(i-1,j); conj(k(i-1,j)) 1]*U;
    end

	e(j,1) = U(2,$);
end
endfunction
function narginchk(l,h,t)
    if t<l then
        error("Too few input arguments");
    elseif t>l then
        error("Too many input arguments");
    end
endfunction
