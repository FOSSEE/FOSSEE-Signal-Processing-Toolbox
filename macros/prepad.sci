// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author: Abinash Singh Under FOSSEE Internship
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Last Modified on : 3 Feb 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

function res = prepad(x,l,c,dim)
// Prepend or truncate a vector or matrix to a specified length.
//
// Syntax
//   res = prepad(x, l)
//   res = prepad(x, l, c)
//   res = prepad(x, l, c, dim)
//
// Parameters
// x: Input vector or matrix.
// l: Desired length (scalar).
// c: (optional) Scalar value to prepend. Default is 0.
// dim: (optional) Dimension along which to operate. Default is 2.
//
// Description
// The `prepad` function prepends the scalar value `c` to the vector or matrix `x` until it reaches the specified length `l`. 
// If `c` is not provided, a value of 0 is used. If the length of `x` exceeds `l`, elements are removed from the beginning of `x` 
// to match the desired length. If `x` is a matrix, the operation is performed along rows or columns based on the `dim` parameter.
//
// Examples
// // Prepend zeros to a row vector to make its length 6
// res1 = prepad([1, 2, 3, 4], 6);
// disp("Result 1:");
// disp(res1); // Output: [0, 0, 1, 2, 3, 4]
// 
// Authors
// Abinash Singh


    if nargin < 2 then 
        error("Usage :  postpad(x,l,c(optional),dim(optional))")
    end
    if nargin < 3 then 
        c = 0 ;
    end
    if nargin < 4 then 
        dim = find(size(x)>1)
        if isempty(dim) then dim = 2 end
        if isvector(dim) then dim = dim(1) end
    end

    if l < size(x,dim) then
        if isvector(x) then 
            start = length(x) - l+1;
            res=x(start:$)
            return;
        else
            error("prepad : l must be greter than dim size for matrices")
        end
        
    end
    
    if dim == 1 then 
        res = [ c* ones( l - size(x,1) , size(x,2)) ; x]
    elseif dim == 2 then 
        res = [ c* ones( size(x,1) , l - size(x,2)) x]
    else
        error("prepad : Invalid value for arg dim 1 or 2 expected")
    end
endfunction

/*
#test for row vectors
prepad([1 2 3 4],6) 
prepad([1 ;2 ;3 ;4],6) 
prepad([1 2 3 4;5 6 7 8;9 10 11 12],6) 
prepad([1 2 ;3 4;5 6],6,-1) 

// FIXME : Tests for 2d and high dimesnsional matrices
*/
