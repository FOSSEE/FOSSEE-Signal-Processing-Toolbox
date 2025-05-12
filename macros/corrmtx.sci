function [X, varargout] = corrmtx(x, m, varargin)
// Generate a data matrix for autocorrelation matrix estimation.
//
// Syntax
//   X = corrmtx(x, m)
//   [X, R] = corrmtx(x, m)
//   X = corrmtx(x, m, s)
//   [X, R] = corrmtx(x, m, s)
//
// Parameters
// x: Vector. Input vector of size N for which the correlation matrix of size `m` is to be calculated.
// m: Positive integer. Size of the correlation matrix to be computed. Must be strictly smaller than the length of `x`.
// s: String. Method for the type of output matrix `X`. Options are:
//    - 'autocorrelation' (default): Generates an autocorrelation estimate.
//    - 'prewindowed': Uses prewindowed data.
//    - 'postwindowed': Uses postwindowed data.
//    - 'covariance': Uses nonwindowed data.
//    - 'modified': Uses forward and backward prediction error estimates.
// X: Matrix. Data matrix as specified by the input `s`.
// R: Matrix. Autocorrelation matrix estimate calculated as `X'*X`.
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
// x = [1, 2, 3, 4, 5];
// m = 3;
// [X, R] = corrmtx(x, m, 'autocorrelation')
// See also
// peig
// pmusic
// rooteig
// rootmusic
// xcorr
//
// Authors
// Parthe Pandit
//
// Bilblography
// Marple, S. Lawrence. Digital Spectral Analysis. Englewood Cliffs, NJ: Prentice-Hall, 1987.
//

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
