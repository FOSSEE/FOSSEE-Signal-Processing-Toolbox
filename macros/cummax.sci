// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/signal/
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Date of Modification: 13 March 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
function [M, iM] = cummax(varargin)
// Compute the cumulative maximum.
//
// Syntax
//   M = cummax(A)
//   M = cummax(A, dim)
//   M = cummax(_, direction)
//   [M, iM] = cummax(...)
//
// Parameters
// A: Vector or matrix. Input array containing real or complex numbers.
// dim: Positive integer. Dimension to operate along. Default is the first non-singleton dimension.
// direction: String. Direction of cumulation. Can be 'forward' (default) or 'reverse'.
// M: Vector or matrix. Cumulative maximum values.
// iM: Vector or matrix. Indices of the maximum values.
//
// Description
// This function computes the cumulative maximum of the input array `A`. For complex elements, the function compares magnitudes, and if magnitudes are equal, it compares phase angles. The operation can be performed along a specified dimension and in a specified direction.
//
// Examples
//  //Cumulative maximum values in a vector:
//    v = [8, 9, 1, 10, 6, 1, 3, 6, 10, 10];
//    M = cummax(v)
//   
//
//  //Cumulative maximum along a specific dimension:
//    x = [1, 2, 3; 4, 1, 2; 3, 5, 1];
//    M = cummax(x, 2)
//
// // Cumulative maximum with indices:
//    [M, iM] = cummax(x, 2)
// 

    [numOutArgs,numInArgs] = argn(0);
    
    // ** Checking number of arguments
    
    if numInArgs<1 | numInArgs>3 then
        msg = "cummax: Wrong number of input argument; 1-6 expected";
        error(77,msg);
    end
    
    if numOutArgs > 2 then
        msg = "cummax: Wrong number of output argument; 1 or 2 expected";
        error(78,msg);
    end
    
    
    // ** Parsing input args **
    
    // defining default arguments
    isForward = %t;
    dim = [];
    directionArg = "";
    A = varargin(1);
    
    // A should contain numeric entries
    if ~(type(A)==1 | type(A)==8 | type(A)==17) then
        msg = "cummax: Wrong type for argument #1 (A); Real or complex entries expected ";
        error(53,msg);
    end
    
    if numInArgs>1 then
        temp = varargin(2);
        if type(temp)==10 then
            // it is the direction argument
            directionArg = temp;
        elseif type(temp)==1 | type(temp)==8 then
            dim = int(temp);
        else
            msg = "cummax: Wrong type for argument #2; Either dim (integer) or direction (string) expected";
            error(53,msg);
        end
    end
    
    if numInArgs>2 then
        directionArg = varargin(3);
        if type(directionArg)~=10 then
            msg = "cummax: Wrong type for argument #3 (direction); String expected";
            error(53,msg);
        end
    end
    
    if isempty(dim) then
        dimArray = 1:ndims(A);
        dim = find(size(A)~=1,1);
    end
    
    // additional checks on dim
    if size(A,dim)==1 then
        M = A;
        return
    end
    
    // extracting direction
    if strcmp(directionArg,"reverse")==0 then
        isForward = %f;
    elseif strcmp(directionArg,"forward")==0 then
        isForward = %t;
    elseif strcmp(directionArg,"")~=0 then
        msg = "cummax: Wrong value for argument #3 (direction)";
        error(53,msg);
    end
    
    sizeA = size(A);
    sizeDim = size(A,dim);
    
    // restructuring A into a 3D matrix with the specified dimension as the middle elements
    
    leftSize = prod(sizeA(1:dim-1));
    rightSize = prod(sizeA(dim+1:$));
    middleSize = sizeDim;
    
    
    A_ = matrix(A,[leftSize,middleSize,rightSize]);
    M_ = zeros(leftSize,middleSize,rightSize);
    
    for i=1:leftSize
        for j=1:rightSize
            M_(i,:,j) = cummaxVec(A_(i,:,j),isForward);
        end
    end
        
    M = matrix(M_,sizeA);
    
    if numOutArgs == 2 then
        // calculating the index 
        // for vectors
        iM = zeros(sizeA(1),sizeA(2));
        for i=1:sizeA(1)
            for j=1:sizeA(2)
                index = find (M(i,j) == A(i,:) )
                iM(i,j) = index(1)
            end
        end
    end
endfunction
    
    
function out = cummaxVec(inp,isForward)
    // performs cummax on vector inputs

    if isForward then
        startIndex=1;
        endIndex = length(inp);
        step = 1;
    else
        startIndex=length(inp);
        endIndex = 1;
        step = -1;
    end
    
    out(startIndex) = inp(startIndex);
    if isreal(inp) then
        for i=startIndex+step:step:endIndex
            if isnan(out(i-step)) then
                out(i) = inp(i);
            elseif inp(i)>=out(i-step) then
                out(i) = inp(i);
            else
                out(i) = out(i-step);
            end
        end
    else
        magVec = abs(inp);
        phaseVec = atan(imag(inp),real(inp)); 
        
        // phase - first compare absolute value; then give priority to positive phases
        
        prevMag = magVec(startIndex);
        prevPhase = phaseVec(startIndex);
        
        for i=(startIndex+step):step:endIndex
            if isnan(out(i-step)) then
                out(i) = inp(i);
                prevMag = magVec(i);
                prevPhase = phaseVec(i);
            elseif magVec(i)>prevMag then
                out(i) = inp(i);
                prevMag = magVec(i);
                prevPhase = phaseVec(i);
            elseif magVec(i)<prevMag then
                out(i) = out(i-step);
            else
                if phaseVec(i)>prevPhase then
                    out(i) = inp(i);
                    prevMag = magVec(i);
                    prevPhase = phaseVec(i);
                else
                    out(i) = out(i-step);
                end
            end
        end
    end
endfunction
/*
# tests
[w, iw] = cummax ([1 3 2 6 4 5]); // passed
x = [1 2 3; 4 1 2; 3 5 1];
w = cummax(x); //passsed

x = [1 2 3; 4 1 2; 3 5 1];
w = cummax(x, 2); // passed

x = [1 2 3; 4 1 2; 3 5 1];
[w,iw] = cummax(x, 2); // passed
*/