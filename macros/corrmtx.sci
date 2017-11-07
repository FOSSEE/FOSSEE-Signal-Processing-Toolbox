function [X,varargout]= corrmtx(x,m,varargin)
// Generate data matrix for autocorrelation matrix estimation
//
// Calling Sequence
// X = corrmtx(x,m)
// [X,R] = corrmtx(x,m)
// X = corrmtx(x,m,s)
// [X,R] = corrmtx(x,m,s)
// 
// Parameters
// x: input vector of size N for which correlation matrix of size m is to be calculated
// m: size of correlation matrix to be computed. Positive integer strictly smaller than the length of the input x
// X: data matrix as specified according to the input 'method'
// s: method for type of output matrix X
//      'autocorrelation': (default) X is the (n + m)-by-(m + 1) rectangular Toeplitz matrix that generates an autocorrelation estimate for the leng    th-n data vector x, derived using prewindowed and postwindowed data, based on an mth-order prediction error model.
//      'prewindowed': X is the n-by-(m + 1) rectangular Toeplitz matrix that generates an autocorrelation estimate for the length-n data vector x,     derived using prewindowed data, based on an mth-order prediction error model.
//      'postwindowed': X is the n-by-(m + 1) rectangular Toeplitz matrix that generates an autocorrelation estimate for the length-n data vector x    , derived using postwindowed data, based on an mth-order prediction error model.
//      'covariance': X is the (n – m)-by-(m + 1) rectangular Toeplitz matrix that generates an autocorrelation estimate for the length-n data vect    or x, derived using nonwindowed data, based on an mth-order prediction error model.
//      'modified': X is the 2(n – m)-by-(m + 1) modified rectangular Toeplitz matrix that generates an autocorrelation estimate for the length-n d    ata vector x, derived using forward and backward prediction error estimates, based on an mth-order prediction error model.
// R: (m + 1)-by-(m + 1) autocorrelation matrix estimate calculated as X'*X
//
// Description
// Consider the generic matrix X below
//     _                _
//    | x(1) ..........0 |
//    | :      .       : |
//    | :       .      : |
//    | x(m+1).......x(1)|
//    | :      .       : |
//    | :       .      : |
//X = | x(n-m).....x(m+1)|
//    | :      .       : |
//    | :       .      : |
//    | x(n).......x(n-m)|
//    | :      .       : |
//    | :       .      : |
//    |_0 ..........x(n)_|
// --
// For different inputs of string s the output would vary ass described below
// 'autocorrelation' — (default) X = X, above.
// 'prewindowed' — X is the n-by-(m + 1) submatrix of X whose first row is [x(1) … 0] and whose last row is [x(n) … x(n – m)]
// 'postwindowed' — X is the n-by-(m + 1) submatrix of X whose first row is [x(m + 1) … x(1)] and whose last row is [0 … x(n)]
// 'covariance' — X is the (n – m)-by-(m + 1) submatrix of X whose first row is [x(m + 1) … x(1)] and whose last row is [x(n) … x(n – m)]
// 'modified' — X is the 2(n – m)-by-(m + 1) matrix X_mod shown below
//         _                _
//        | x(m+1) ......x(1)|
//        | :      .       : |
//        | :       .      : |
//        | x(n-m).....x(m+1)|
//        | :      .       : |
//        | :       .      : |
//        | x(n).......x(n-m)|
// X_mod= | x*(1).....x*(m+1)|
//        | :      .       : |
//        | :       .      : |
//        | x*(m+1)...x*(n-m)|
//        | :      .       : |
//        | :       .      : |
//        |_x*(n-m) ...x*(n)_|
//
// Examples
// 
// 
//
// See also
// peig
// pmusic
// rooteig
// rootmusic
// xcorr
//
// Author:
// Parthe Pandit
//
// Bilbligraphy
// Marple, S. Lawrence. Digital Spectral Analysis. Englewood Cliffs, NJ: Prentice-Hall, 1987.



    if(~isvector(x)) then
        error("Input x must be a length n vector")
        return
    elseif (~isscalar(m)) then
        error("Input m must be scalar")
        return
    end
    
    if (length(varargin) > 1) then
        error('Too many input arguments. Third argument must be method for correlation matrix computation')
        return
    elseif (length(varargin) < 1)
        method = 'autocorrelation';
    elseif (length(varargin) == 1 & type(varargin(1))~=10)
        disp(type(varargin));
        error("Input method needs to be string")
        return
    else
        method = varargin(1);
    end
    n = length(x);
    x = matrix(x,1,n);
    x_padded = [zeros(1,m),x,zeros(1,m)];
    X = zeros( (n + m),(m + 1) );
    for i = 1:size(X,1)
        X(i,:) = x_padded(m+i:-1:i);
    end
    
    select method
    case "autocorrelation" then
        X = X;
    case 'prewindowed' then
        X = X(1:n,:);
    case 'postwindowed' then
        X = X(m+1:$,:);
    case 'covariance' then
        X = X(m+1:n,:);
    case 'modified' then
        X = [X(m+1:n,:)  ; conj(mtlb_fliplr(X(m+1:n,:)))];
    else X = X;
end

    
    varargout = list(X'*X);
    
    
endfunction
