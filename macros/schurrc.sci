//schurrc - Schur algorithm.
//K = SCHURRC(R) computes the reflection coefficients from autocorrelation vector R. If R is a matrix, SCHURRC finds coefficients for each column of R, and returns them in the columns of K.
//[K,E] = SCHURRC(R) returns the prediction error variance E. If R is a matrix, SCHURRC finds the error for each column of R, and returns them in the rows of E.
//Modified to match matlab i/p and o/p and handle exceptions
//Fixed bugs
//by Debdeep Dey

//////EXAMPLES:
//m=linspace(1,100);
//r = xcorr(m(1:5),'unbiased');.......autocorrelation vector
//[k,e] = schurrc(r(5:$))

//EXPECTED OUTPUT
//e  =1.6212406
 //k  = - 0.9090909  0.2222222  0.2244898  0.2434211




function [k,e] = schurrc(R)
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
