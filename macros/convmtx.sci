//Convolution Matrix
//convmtx(h,n) returns the convolution matrix for vector h. If h is a
//column vector and X is a column vector of length n, then convmtx(h,n)*X
//gives the result of the convolution oof h and X.If R is a row vector and X//is a row vector of length N, then X*convmtx(R,N) gives the convolution of R and X.
//Example:
//Generate a simple convolution matrix.
//
// h = [%i 1 2 3];
// convmtx(h,7)       //Convolution matrix
//
//Author 
//Debdeep Dey
function t=convmtx(v,n);
    n=double(n);
    [mv,nv]=size(v);
    v=v(:);
    
    //put Toeplitz code inline
    c = [v; zeros(n-1,1)]; 
    r = zeros(n,1);
    m = length(c);
    x = [r(n:-1:2) ; c(:)]; 
    
    cidx = (0:m-1)';
        ridx = n:-1:1;
    t = cidx(:,ones(n,1)) + ridx(ones(m,1),:); //Toeplitz subscripts
    t(:) = x(t); //actual data
    
         //t = single(t);
    // end of toeplitz code

if mv < nv then
    t = t.';
    end
    
endfunction
