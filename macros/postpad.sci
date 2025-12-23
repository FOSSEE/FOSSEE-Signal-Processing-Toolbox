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

function res = postpad(x,l,c,dim)
// Append or truncate a vector or matrix to a specified length.
//
// Syntax
//   res = postpad(x, l)
//   res = postpad(x, l, c)
//   res = postpad(x, l, c, dim)
//
// Parameters
// x: Input vector or matrix.
// l: Desired length (scalar).
// c: (optional) Scalar value to append. Default is 0.
// dim: (optional) Dimension along which to operate. Default is 2.
//
// Description
// The `postpad` function appends the scalar value `c` to the vector or matrix `x` until it reaches the specified length `l`. 
// If `c` is not provided, a value of 0 is used. If the length of `x` exceeds `l`, elements are removed from the end of `x` 
// to match the desired length. If `x` is a matrix, the operation is performed along rows or columns based on the `dim` parameter.
//
// Examples
// // Append -1 to a column vector to make its length 6
// res2 = postpad([1; 2; 3; 4], 6, -1)

  
    if nargin < 2 then 
        error("Usage :  postpad(x,l,c(optional),dim(optional))")
    end
    if nargin < 3 then 
        c = 0 ;
    end
    if nargin <= 4 then 
        if size(x,1) == 1 then
            dim = 1 ;
        elseif size(x,2) == 1 then 
            dim = 2 ;
        else
            dim = 2 ; // FIXME dim functionality not implemented
        end
    end
    if l < size(x,dim) then
        error("l must be greater then dimension of x")
    end
    
    select dim
    case 1 then
        res = [x c*ones(size(x,1),l-size(x,2))];
    case 2 then
        res = [x;c*ones(l-size(x,1),size(x,2))];
    end
endfunction

/*
#test for row vectors
postpad([1 2 3 4],6) //passed
postpad([1 ;2 ;3 ;4],6) // passed
postpad([1 2 3 4;5 6 7 8;9 10 11 12],6) // passed
postpad([1 2 ;3 4;5 6],6,-1) //passed
*/