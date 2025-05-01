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

function y = prepad(x, n, padval)
// Prepads the scaler value c to vector x
//
// Syntax
//   y = prepad(x, n)
//   y = prepad(x, n, padval)
//
// Parameters
// x: Input array.
// n: Desired length of the output array.
// padval: Value to pad with. Default is 0.
// y: Output array padded to the desired length.
//
// Description
// This function pads the input array `x` to the desired length `n` by adding `padval` at the beginning.
//
// Examples
// y = prepad([1, 2, 3], 5, 0)
//
// Authors
//  Abinash Singh (abinashlalotra@gmail.com)

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
